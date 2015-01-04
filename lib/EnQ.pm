package EnQ;
use strict; 
use warnings;

use YAML;

sub init {
    my ($class, $args) = @_; 
    my $self = {
	config => $args->{'config'} || undef,
    };

    if(defined $self->{'config'}){
	my $conf = YAML::LoadFile($self->{'config'});
	$self = {%$self, %$conf};
    }
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
