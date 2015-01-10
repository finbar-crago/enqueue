package EnQ::Obj::Test;
use strict;
use warnings;

use parent qw(EnQ::Object);

our $Object = {
    def => {
	'id' => EnQ::Object::Field(),
	'read'  => EnQ::Object::Field('READ'),
	'write' => EnQ::Object::Field('WRITE'),
	'regex' => EnQ::Object::Field('REGEX',{regex=>'^[a-z]+$'}),
	'cb' => EnQ::Object::Field('CB',{cb=>\&cbTest}),
    },
    db => {
	key   => 'id',
	table => 'test',
	setup => 'CREATE TABLE test (id TEXT PRIMARY KEY, read TEXT, write TEXT, regex TEXT, cb TEXT)',
    },
};

sub cbTest {
    my $self = shift;
    my ($value) = @_;
    $value =~ tr/a-z/d-za-b/;
    return $value;
}

1;
