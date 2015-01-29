package EnQ::Obj::DID;
use strict;
use warnings;

use parent qw(EnQ::Object);

our $Object = {
    def => {
	'did'       => EnQ::Object::Field(),
	'act'       => EnQ::Object::Field(),
	'act_queue' => EnQ::Object::Field(),
	'act_exten' => EnQ::Object::Field(),
	'act_user'  => EnQ::Object::Field(),
    },
    db => {
	key   => 'did',
	table => 'did',
	setup => 'CREATE TABLE did (did TEXT PRIMARY KEY, act TEXT, act_queue TEXT, act_exten TEXT)',
    },
};

1;
