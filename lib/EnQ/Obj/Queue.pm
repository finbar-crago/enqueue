package EnQ::Obj::Queue;
use strict;
use warnings;

=head1 NAME

EnQ::Obj::Queue - EnQ Queue Object

=head1 SYNOPSIS

  package EnQ;
  my $Q = EnQ->new({config_file => 'config.yml'});
  my $U = $Q->Obj('Queue');

  
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

use parent qw(EnQ::Object);

our $Object = {
    def => {
	'qid' => EnQ::Object::Field(),
	'txt' => EnQ::Object::Field(),
    },
    db => {
	key   => 'qid',
	table => 'queues',
	setup => 'CREATE TABLE queues (qid TEXT PRIMARY KEY, txt TEXT)',
    },
};

1;
