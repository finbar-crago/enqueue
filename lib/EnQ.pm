package EnQ;
use strict; 
use warnings;

=head1 NAME

EnQ - The Enqueue PBX Libraries

=head1 SYNOPSIS

  use EnQ;

  my $Q = EnQ->new({config => 'my_config.yml'});

  my $U = $Q->Obj('User');
  $U->pull('user_id');
  print $U->name;

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
	require;
	if(defined $EnQ::Obj::{s|.+/([^.]+)\.pm|$1::|r}{'_load'}){
	    $self->{'Obj'}{s|.+/([^.]+)\.pm|$1|r} = &{$EnQ::Obj::{s|.+/([^.]+)\.pm|$1::|r}{'_load'}}(\$self);
	} else {
	    $self->{'Obj'}{s|.+/([^.]+)\.pm|$1|r} = ${$EnQ::Obj::{s|.+/([^.]+)\.pm|$1::|r}{'Object'}};
	}
    }

    if(defined $self->{'db'}){
	$self->{'_db'} = EnQ::DBA->new($self->{'db'});
	$self->{'_db'}->connect();
	$self->{'_db'}->_db_init($self->{'Obj'}) ;
    }
}

1;
