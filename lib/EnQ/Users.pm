package EnQ::Users;
use strict;
use warnings;

use parent qw(EnQ::Object);
use constant { READ => 1, WRITE => 2, REQURED => 4, REGEX => 8, CB => 16 };

my $Object = {
    data => {
	uid  => {mode => READ|WRITE},
	extn => {mode => READ|WRITE},
    },
    db => { table  => 'users', },
};

sub new {
    my $class = shift;
    my $closure = EnQ::Object::_init($Object);
    return bless $closure, $class;
}

1;
