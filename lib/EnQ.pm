package EnQ;
use strict; 
use warnings;

use EnQ::Users;

sub init {
    my $class = shift;
    my $self = {};
    return bless $self, $class;
}

sub new {
    my $self = shift;
    my ($mod) = @_;
    return undef if $mod !~ /^[a-z:]+$/i;
    my $object =  eval "EnQ::$mod->new();";
    ${$object->_parent} = $self;

    return $object;
}

1;
