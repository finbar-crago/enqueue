package EnQ::DBA;
use strict;
use warnings;

use DBI;

my $SQL = {
    SQLite => {
	GET => 'SELECT * FROM <TABLE> WHERE <KEY> = "<ID>"',
	PUT => 'INSERT OR REPLACE INTO <TABLE> (<FIELDS>) VALUES (<DATA>);',
	DEL => 'DELETE FROM <TABLE> WHERE <KEY> = "<ID>"',
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
    my ($self, $table, $key, $id) = @_;

    my $sth = $self->{'dbh'}->prepare($SQL->{$self->{type}}->{GET});
    $sth->execute($id);
    return $sth->fetchrow_hashref;
}

sub put { }
sub del { }

1;
