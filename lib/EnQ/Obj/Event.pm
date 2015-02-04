package EnQ::Obj::Event;
use strict;
use warnings;

use parent qw(EnQ::Object);

our $Object = {
    def => {
	'eid'  => EnQ::Object::Field(),
	'type' => EnQ::Object::Field(),
	'time' => EnQ::Object::Field(),
	'json' => EnQ::Object::Field(),
    },
    db => {
	key   => 'eid',
	table => 'events',
	setup => 'CREATE TABLE events (eid TEXT PRIMARY KEY, type TEXT, time TEXT, json TEXT)',
    },
};

1;
