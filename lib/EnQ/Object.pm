package EnQ::Object;
use strict;
use warnings;

=head1 NAME

EnQ::Object - The Enqueue PBX Core Object Library

=head1 SYNOPSIS

  package EnQ::Obj::User
  use parent qw(EnQ::Object);

  sub new {
     my $class = shift;
     EnQ::Object::add($Object, 'uid');
     EnQ::Object::add($Object, 'name');
     EnQ::Object::add($Object, 'extn',
		      {mode => 'REGEX', regex => '^[0-9]+$'});

     my $closure = EnQ::Object::_init($Object);
     return bless $closure, $class;
  }

  my $Q = EnQ->new({config => 'my_config.yml'});
  my $U = $Q->Obj('User');

  $U->pull('user_id');
  print $U->name;
  $U->extn("1234") or print $u->is_error();
  $U->push();

  $dump_all = $U->data();
  $bypass_closure = ${$U->_db}->{'key'};
  ${$U->_parent} = $more_bypassing;

=head1 AUTHOR

Finbar Crago <finbar.crago@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2014, 2015 Finbar Crago

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see L<http://www.gnu.org/licenses/>.

=cut

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
	return \$self->{$1} if $field =~ /^_(.+)/;
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

sub Field {
    my ($obj) = @_;

    my $i = 0;
    $obj->{'mode'}|='';
    for(split /\|/, $obj->{'mode'}){
	if    ($_ eq 'READ'   ){ $i|= 1  }
	elsif ($_ eq 'WRITE'  ){ $i|= 2  }
	elsif ($_ eq 'REQURED'){ $i|= 4  }
	elsif ($_ eq 'REGEX'  ){ $i|= 8  }
	elsif ($_ eq 'CB'     ){ $i|= 16 }
    }
    if(!($i & (READ|WRITE))){
	$i|=(READ|WRITE);
    }
    $obj->{'mode'} = $i;
    return $obj;
}

sub push {
    my $self = shift;
    ${$self->_parent}->{'_db'}->put(${$self->_db}->{'table'}, ${$self->_db}->{'key'}, $self->data);
}

sub pull {
    my $self = shift;
    my ($id) = @_;
    my $key = ${$self->_db}->{'key'};
    my $data = ${$self->_parent}->{'_db'}->get(${$self->_db}->{'table'}, $key, $id);
    if(defined $data){ $self->$_($data->{$_}) for (keys $data); }
    ${$self->_data}->{$key}->{'value'} = $id;
}

sub data {
    my $this = shift;
    my $ret = {};
    for (keys ${$this->_data}){
	$ret->{$_} = $this->$_;
    }
    return $ret;
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
