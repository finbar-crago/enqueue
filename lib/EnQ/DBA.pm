package EnQ::DBA;
use strict;
use warnings;

=head1 NAME

EnQ::DBA - Enqueue PBX Database Stuff

=head1 SYNOPSIS

  package EnQ::Obj::Example;
  use parent qw(EnQ::Object);

  my $Object = {
    db => {
      key   => 'uid',
      table => 'table_name',
      setup => 'CREATE TABLE table_name (uid TEXT PRIMARY KEY, name TEXT)',
    },
  };

=head1 AUTHOR

Finbar Crago <finbar.crago@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2014, 2015 Finbar Crago

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see L<http://www.gnu.org/licenses/>.

=cut

use DBI;

my $SQL = {
    SQLite => {
	GET => 'SELECT * FROM <TABLE> WHERE <KEY> = ?',
	PUT => 'INSERT OR REPLACE INTO <TABLE> (<FIELDS>) VALUES (<DATA>);',
	DEL => 'DELETE FROM <TABLE> WHERE <KEY> = "<ID>"',
	LIST_TABLES => 'SELECT * FROM sqlite_master WHERE type = "table";'
    },
};

sub new {
    my ($class, $args) = @_;
    my $self = {
	dbh  => undef,
	type => $args->{'type'} || undef,
	conn => $args->{'conn'} || undef,
	user => $args->{'user'} || undef,
	pass => $args->{'pass'} || undef,
    };

    return bless $self, $class;
}

sub connect {
    my $self = shift;
    $self->{'dbh'} = DBI->connect($self->{'conn'}, $self->{'user'}, $self->{'pass'});
    return $self->{'dbh'};
}

sub Q {
    my $self = shift;
    my ($sql, @args) = @_;
    return $self->{'dbh'}->selectall_arrayref($sql);
}

sub QObj {
    use Data::Dumper;
    my $self = shift;
    my ($obj, $args) = @_;
    $args = '1' if !$args;

    my $o = "EnQ::Obj::$obj"->new();
    return undef if !$o->_db;
    my $db = ${$o->_db};

    my $sql = sprintf("SELECT * FROM %s WHERE %s", $db->{'table'}, $args);
    my $dat = $self->{'dbh'}->selectall_hashref($sql, $db->{'key'});

    my $ret = {};
    foreach my $i (keys $dat){
	$ret->{$i} = "EnQ::Obj::$obj"->new();
	$ret->{$i}->Data($dat->{$i});
    }
    return $ret;
}

sub QObjData {
    my $self = shift;
    my ($obj, $args) = @_;
    $args = '1' if !$args;

    my $db = ${$EnQ::Obj::{$obj.'::'}{'Object'}}->{'db'};
    return undef if ! $db;

    my $sql = sprintf("SELECT * FROM %s WHERE %s", $db->{'table'}, $args);
    my $dat = $self->{'dbh'}->selectall_hashref($sql, $db->{'key'});

    my $ret = {};
    foreach my $i (keys $dat){
	$ret->{$i} = {"EnQ::Obj::$obj"->new()->Data($dat->{$i})};
    }
    return $ret;
}

sub get {
    my $self = shift;
    my ($table, $key, $id) = @_;
    my $Q = $SQL->{$self->{type}}->{GET};
    $Q =~ s|<TABLE>|$table|g;
    $Q =~ s|<KEY>|$key|g;
    my $sth; (($sth = $self->{'dbh'}->prepare($Q)) && $sth->execute($id)) || (return undef);
    return $sth->fetchrow_hashref;
}

sub put {
    my $self = shift;
    my ($table, $key, $data) = @_;

    my $f = join(',', (keys $data));
    my $d = join(',', ('?')x(0+keys($data)));

    my $Q = $SQL->{$self->{type}}->{PUT};
    $Q =~ s|<TABLE>|$table|g;
    $Q =~ s|<KEY>|$key|g;
    $Q =~ s|<FIELDS>|$f|g;
    $Q =~ s|<DATA>|$d|g;

    my $sth; (($sth = $self->{'dbh'}->prepare($Q)) && $sth->execute((values $data))) || (return undef);
    return 1;
}

sub del {
    my $self = shift;
    my ($table, $key, $id) = @_;

    my $Q = $SQL->{$self->{type}}->{DEL};
    $Q =~ s|<TABLE>|$table|g;
    $Q =~ s|<KEY>|$key|g;
    $Q =~ s|<ID>|$id|g;

    my $sth = $self->{'dbh'}->do($Q) || return undef;
}

sub error {
    my $self = shift;
    return $self->{'dbh'}->errstr;
}

sub _db_init {
    my $self = shift;
    my ($ObjList) = @_;

    my $sth = $self->{'dbh'}->prepare($SQL->{$self->{type}}->{LIST_TABLES});
    $sth->execute();
    my $tables = $sth->fetchall_hashref('name');

    for (keys $ObjList){
	my $db = $ObjList->{$_}->{db};
	if(defined($db->{table}) && !defined($tables->{$db->{table}})){
	    $self->{'dbh'}->do($db->{setup});
	}
    }
}

1;
