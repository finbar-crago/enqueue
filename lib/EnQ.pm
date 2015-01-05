package EnQ;
use strict; 
use warnings;

use EnQ::DBA;
use YAML;

sub new {
    my ($class, $args) = @_; 
    my $self = {
	config => $args->{'config'} || undef,
    };

    if(defined $self->{'config'}){
	my $conf = YAML::LoadFile($self->{'config'});
	$self = {%$self, %$conf};
    }

    if(defined $self->{'db'}){
	$self->{'_db'} = EnQ::DBA->new($self->{'db'});
	$self->{'_db'}->connect();
    }

    my $this = bless($self, $class);
    $this->ObjInit();
    return $this;
}

sub Obj {
    my $self = shift;
    my ($mod) = @_;
    return undef if $mod !~ /^[a-z]+$/i;
    my $o = eval "EnQ::Obj::$mod->new();";
    ${$o->_parent} = $self;
    return $o;
}

sub ObjInit {
    my $self = shift;
    for (glob $INC{"EnQ.pm"} =~ s|(.+/EnQ).pm|$1/Obj/*.pm|r){
	require; &{$EnQ::Obj::{s|.+/([^.]+)\.pm|$1::|r}{'_load'}}(\$self);
    }
}

1;
