package EnQ::Obj::User;
use strict;
use warnings;

use parent qw(EnQ::Object);

my $Object = {
    data => {
	'uid'  => EnQ::Object::Field(),
	'name' => EnQ::Object::Field(),
	'extn' => EnQ::Object::Field({mode => 'REGEX', regex => '^[0-9]+$'}),
	'pass' => EnQ::Object::Field(),
    },
    db => {
	key   => 'uid',
	table => 'users',
	setup => 'CREATE TABLE users (uid TEXT PRIMARY KEY, name TEXT, extn TEXT, pass TEXT)',
    },
};

sub new {
    my $class = shift;
    my $closure = EnQ::Object::_init($Object);
    return bless $closure, $class;
}

sub _load {
    my $parent = shift;
    return $Object;
}

1;
