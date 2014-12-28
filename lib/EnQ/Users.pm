package EnQ::Users;
use strict;
use warnings;

use parent qw(EnQ::Object);

my $Object = {
    data => { },
    db => { table  => 'users', },
};

sub new {
    my $class = shift;
    EnQ::Object::add($Object, 'uid');
    EnQ::Object::add($Object, 'extn', {mode => 'READ|WRITE|REGEX', regex => '^[0-9]+$'});
    my $closure = EnQ::Object::_init($Object);
    return bless $closure, $class;
}

1;
