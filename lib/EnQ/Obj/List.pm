package EnQ::Obj::List;
use strict;
use warnings;

use parent qw(EnQ::Object);

our $Object = {
    def => {
	'list' => EnQ::Object::Field(),
	'type' => EnQ::Object::Field('CB',{cb=>\&getList}),
    },
};

sub getList {
    my $self = shift;
    my ($type) = @_;

    my $table = $self->{'parent'}->{'Obj'}->{$type}->{'db'}->{'table'};
    $self->{'data'}{'list'} = '...'; ## <-- DB Stuff goes here!
    return 1;
}

1;
