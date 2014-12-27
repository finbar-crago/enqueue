package EnQ::Object;
use strict;
use warnings;

use constant {
    READ    => 1,
    WRITE   => 2,
    REQURED => 4,
    REGEX   => 8,
    CB      => 16
};

sub _init {
    my $mod  = shift;
    my $self =
    {
	id     => undef,
	parent => undef,
	type   => undef,
	data   => $mod->{'data'} || undef,
	db     => $mod->{'db'}   || undef,
	_error => undef,
    };


    my $_closure = sub{
	my $field = shift;
	return $self->{'_error'} if $field eq '_error';
	return $self->{'data'}{$field} if $field =~ /^_/;
	$self->{'_error'} = undef;

	if(!exists($self->{'data'}{$field})){
	    $self->{'_error'} = 'field undefined';
	    return undef;
	}

	if(@_){ #write var

	    if($self->{'data'}{$field} && $self->{'data'}{$field}{'mode'} & WRITE){
		my $value = shift;

		if($self->{'data'}{$field}{'mode'} & REGEX){
		    my $regex = $self->{'data'}{$field}{'regex'};
		    if($value =~ m/$regex/){
			$self->{'data'}{$field}{'value'} = $value;
			return $value;
		    } else {
			$self->{'_error'} = 'faild regex';
			return undef;
		    }
		}

		if($self->{'data'}{$field}{'mode'} & CB){
		    my $r = &{ $self->{'data'}{$field}{'cb'} }($value);
		    if($r){
			$self->{'data'}{$field}{'value'} = $r;
			return $r;
		    } else {
			$self->{'_error'} = 'faild callback';
		    }
		}

		$self->{'data'}{$field}{'value'} = $value;
		return $value;

	    } else {
		$self->{'_error'} = 'cannot write';
		return undef;
	    }
	} else { #read var
	    if($self->{'data'}{$field} && $self->{'data'}{$field}{'mode'} & READ){
		return $self->{'data'}{$field}{'value'};
	    } else {
		$self->{'_error'} = 'cannot read';
		return undef;
	    }
	}
    };

    return $_closure;
}

sub new {
    my $class = shift;
    my $self = {};
    my $closure = _init($self);
    return bless $closure, $class;
}

sub is_error {
    my $self = shift;
    if($self->_error){
	return $self->_error;
    } else {
	return undef;
    }
}

sub AUTOLOAD {
    our $AUTOLOAD =~ s/.*:://;
    &{ $_[0] }($AUTOLOAD, @_[1 .. $#_ ] )
}

1;
