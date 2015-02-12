package EnQ::Obj::User;
use strict;
use warnings;

=head1 NAME

EnQ::Obj::User - EnQ User Object

=head1 SYNOPSIS

  package EnQ;
  my $Q = EnQ->new({config_file => 'config.yml'});

  my $U = $Q->Obj('User');
  $U->Data({
  	uid=>'finbar',
  	name=>'Finbar Cragp',
  	extn=>'5377',
  	pass=>'myPass',
  });

  print $U->name if $U->chackPass('tryPass');
  
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

use Digest;

use parent qw(EnQ::Object);

our $Object = {
    def => {
	'uid'  => EnQ::Object::Field(),
	'name' => EnQ::Object::Field(),
	'extn' => EnQ::Object::Field('REGEX',{regex =>'^[0-9]+$'}),
	'base' => EnQ::Object::Field(),
	'pass' => EnQ::Object::Field('WRITE|REGEX|CB',{regex=>'.{8}', cb=>\&hashPass}),
	'ast_pass' => EnQ::Object::Field(),
    },
    db => {
	key   => 'uid',
	table => 'users',
	setup => 'CREATE TABLE users (uid TEXT PRIMARY KEY, name TEXT, extn TEXT, base TEXT, pass TEXT, ast_pass TEXT)',
    },
};

sub hashPass {
    my $self = shift;
    my ($pass) = @_;
    my $salt;
    open(RAND, '/dev/urandom');
    read(RAND, $salt, 16);
    close(RAND);

    my $c = Digest->new('Bcrypt');
    $c->cost(1);
    $c->salt($salt);
    $c->add($pass);

    return sprintf('%s::%s', unpack('H[32]',$c->salt), $c->hexdigest);
}

sub checkPass {
    my $self = shift;
    my ($pass) = @_;

    my ($salt, $hash) = split /::/, ${$self->_data}->{'pass'};
    my $c = Digest->new('Bcrypt'); $c->cost(1);
    $c->salt(pack('H[32]', $salt));
    $c->add($pass);

    return ($hash eq $c->hexdigest);
}

1;
