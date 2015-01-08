package EnQ::Object;
use strict;
use warnings;

=head1 NAME

EnQ::Object - The Enqueue PBX Core Object Library

=head1 SYNOPSIS

  package EnQ::Obj::User
  use parent qw(EnQ::Object);

  our $Object = {
    data => {
        'uid'  => EnQ::Object::Field(),
        'name' => EnQ::Object::Field(),
        'extn' => EnQ::Object::Field('REGEX',{regex =>'^[0-9]+$'}),
        'pass' => EnQ::Object::Field('REGEX|CB',{regex=>'.{8}', cb=>\&hashPass}),
    },
    db => {
        key   => 'uid',
        table => 'users',
        setup => 'CREATE TABLE users (uid TEXT PRIMARY KEY, name TEXT, extn TEXT, pass TEXT)',
    },
  };

  1;

  -----

  my $Q = EnQ->new({config_file => 'my_config.yml'});
  my $U = $Q->Obj('User');

  $U->Pull('user_id');
  print $U->name;
  $U->extn("1234") or print $u->is_error();
  $U->Push();

  $dump_all = $U->Data();
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

sub new {
    my $class = shift;
    my ($parent) = @_;
    my $closure = EnQ::Object::_init($class, $parent);
    return bless $closure, $class;
}

sub Field {
    my ($mode, $obj) = @_;

    my $i = 0;
    $mode|='';
    for(split /\|/, $mode){
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

sub Push {
    my $self = shift;
    ${$self->_parent}->{'DBA'}->put(${$self->_db}->{'table'}, ${$self->_db}->{'key'}, $self->Data);
}

sub Pull {
    my $self = shift;
    my ($id) = @_;
    my $key = ${$self->_db}->{'key'};
    my $data = ${$self->_parent}->{'DBA'}->get(${$self->_db}->{'table'}, $key, $id);
    if(defined $data){ ${$self->_data}->{$_} = $data->{$_} for (keys $data); }
    ${$self->_data}->{$key} = $id;
}

sub Data {
    my $self = shift;
    my ($dat)= shift || {};
    $self->$_($dat->{$_}) for (keys $dat);

    return ${$self->_data};
}

sub is_error {
    my $self = shift;
    if($self->_error){
	return $self->_error;
    } else {
	return undef;
    }
}

sub _init {
    my ($mod, $parent)  = @_;
    my $obj = ${$EnQ::Obj::{$mod=~s|EnQ::Obj::([^:]+)|$1::|r}{'Object'}};
    my $self =
    {
	id     => undef,
	parent => $parent,
	type   => $mod,
	def    => $obj->{'def'} || undef,
	db     => $obj->{'db'}  || undef,
	data   => {},
	_error => undef,
    };

    my $_closure = sub{
	my $field = shift;
	return $self->{'_error'} if $field eq '_error';
	return \$self->{$1} if $field =~ /^_(.+)/;
	$self->{'_error'} = undef;

	if(!exists($self->{'def'}{$field})){
	    $self->{'_error'} = 'field undefined';
	    return undef;
	}

	if(@_){ #write var

	    if($self->{'def'}{$field} && $self->{'def'}{$field}{'mode'} & WRITE){
		my $value = shift || '';

		if($self->{'def'}{$field}{'mode'} & REGEX){
		    my $regex = $self->{'def'}{$field}{'regex'};
		    if($value !~ m/$regex/){
			$self->{'_error'} = 'faild regex';
			return undef;
		    }
		}

		if($self->{'def'}{$field}{'mode'} & CB){
		    $value = &{$self->{'def'}{$field}{'cb'}}($value);
		    if(!$value){
			$self->{'_error'} = 'faild callback';
			return undef;
		    }
		}

		$self->{'data'}{$field} = $value;
		return $value;

	    } else {
		$self->{'_error'} = 'cannot write';
		return undef;
	    }
	} else { #read var
	    if($self->{'data'}{$field} && $self->{'def'}{$field}{'mode'} & READ){
		return $self->{'data'}{$field};
	    } else {
		$self->{'_error'} = 'cannot read';
		return undef;
	    }
	}
    };

    return $_closure;
}

sub AUTOLOAD {
    our $AUTOLOAD =~ s/.*:://;
    &{ $_[0] }($AUTOLOAD, @_[1 .. $#_ ] )
}

1;
