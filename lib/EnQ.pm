package EnQ;
use strict; 
use warnings;

use EnQ::DBA;
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

    if(defined $self->{'db'}){
	$self->{'db'}{'DBA'} = EnQ::DBA->new({ conn => $self->{'db'}{'conn'},
					       user => $self->{'db'}{'user'},
					       pass => $self->{'db'}{'pass'}});
	$self->{'db'}{'DBA'}->connect();
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
