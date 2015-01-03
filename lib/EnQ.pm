package EnQ;
use strict; 
use warnings;

sub init {
    my $class = shift;
    my $self = {};
    return bless $self, $class;
}

sub new {
    my $self = shift;
    my ($mod) = @_;
    return undef if $mod !~ /^[a-z:]+$/i;
    eval "use EnQ::$mod;";
    my $object =  eval "EnQ::$mod->new();";
    ${$object->_parent} = $self;

    return $object;
}

1;
