package EnQ::Users;
use strict;
use warnings;

use parent qw(EnQ::Object);
use constant { READ => 1, WRITE => 2, REQURED => 4, REGEX => 8, CB => 16 };

my $Object = {
    data => { },
    db => { table  => 'users', },
};

sub new {
    my $class = shift;
    EnQ::Object::add($Object, 'uid');
    EnQ::Object::add($Object, 'extn', {mode => READ|WRITE|REGEX, regex => '^[0-9]+$'});
    my $closure = EnQ::Object::_init($Object);
    return bless $closure, $class;
}

1;