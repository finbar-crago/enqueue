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
    my $id = $self->{'parent'}->{'Obj'}->{$type}->{'db'}->{'key'};
    my $l = $self->{'parent'}->{'DBA'}->Q("SELECT $id FROM $table WHERE 1");

    @{$self->{'data'}{'list'}} = map $l->[$_][0],(0..$#{$l});
    return @{$l};
}

1;
