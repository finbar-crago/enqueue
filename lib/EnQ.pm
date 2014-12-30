package EnQ;
use strict; 
use warnings;

use parent qw(EnQ::Object);

sub new {
    my $class = shift;

    my $Object = {
	data => {},
    };
    my $closure = EnQ::Object::_init($Object);
    return bless $closure, $class;
}

1;
