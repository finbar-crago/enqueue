package EnQ::Obj::User;
use strict;
use warnings;

use parent qw(EnQ::Object);

my $Object = {
    data => { },
    db => {
	key   => 'uid',
	table => 'users',
    },
};

sub new {
    my $class = shift;
    EnQ::Object::add($Object, 'uid');
    EnQ::Object::add($Object, 'name');
    EnQ::Object::add($Object, 'extn', {mode => 'REGEX', regex => '^[0-9]+$'});
    EnQ::Object::add($Object, 'sipPass');
    EnQ::Object::add($Object, 'wwwPass');

    my $closure = EnQ::Object::_init($Object);
    return bless $closure, $class;
}

sub confSip {
    my $this = shift;
    my $ret  =
	sprintf("[%d]\n", $this->extn).
	"type=endpoint\n".
	sprintf("context=%s\n", '???').
	sprintf("auth=%d\n", $this->extn).
	sprintf("aor=%d\n", $this->extn);

    return $ret;
}

sub _load {
    my $parent = shift;
    return $Object;
}

1;
