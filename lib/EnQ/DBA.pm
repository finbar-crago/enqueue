package EnQ::DBA;
use strict;
use warnings;

use DBI;

my $SQL = {
    SQLite => {
	GET => 'SELECT * FROM <TABLE> WHERE <KEY> = "<ID>"',
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
	_err => undef,
    };

    return bless $self, $class;
}

sub connect {
    my $self = shift;
    $self->{'dbh'} = DBI->connect($self->{'conn'}, $self->{'user'}, $self->{'pass'});
    return $self->{'dbh'};
}

sub get {
    my $self = shift;
    my ($table, $key, $id) = @_;
    my $Q = $SQL->{$self->{type}}->{GET};
    $Q =~ s|<TABLE>|$table|g;
    $Q =~ s|<KEY>|$key|g;

    my $sth = $self->{'dbh'}->prepare($Q);
    $sth->execute($id);
    return $sth->fetchrow_hashref;
}

sub put {
    my $self = shift;
    my ($table, $key, $data) = @_;

    my $f = join(',',   (keys $data));
    my $d = join(',', (values $data));

    my $Q = $SQL->{$self->{type}}->{PUT};
    $Q =~ s|<TABLE>|$table|g;
    $Q =~ s|<KEY>|$key|g;
    $Q =~ s|<FIELDS>|$f|g;
    $Q =~ s|<DATA>|$d|g;

    my $sth = $self->{'dbh'}->do($Q);
}

sub del {
    my $self = shift;
    my ($table, $key, $data) = @_;

    my $Q = $SQL->{$self->{type}}->{DEL};
    $Q =~ s|<TABLE>|$table|g;
    $Q =~ s|<KEY>|$key|g;
    $Q =~ s|<FIELDS>|$f|g;

    my $sth = $self->{'dbh'}->do($Q);
}

sub _db_init {
    my $self = shift;
    my ($ObjList) = @_;

    my $sth = $self->{'dbh'}->prepare($SQL->{$self->{type}}->{LIST_TABLES});
    $sth->execute();
    my $tables = $sth->fetchall_hashref('name');

    for (keys $ObjList){
	if(!defined $tables->{$ObjList->{$_}->{db}{table}}){
	    $self->{'dbh'}->do($ObjList->{User}->{db}{setup});
	}
    }
}

1;
