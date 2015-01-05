package EnQ::DBA;
use strict;
use warnings;

use DBI;

sub new {
    my ($class, $args) = @_;
    my $self = {
	dbh  => undef,
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

1;
