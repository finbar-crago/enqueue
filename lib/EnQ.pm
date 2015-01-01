package EnQ;
use strict; 
use warnings;

use parent qw(EnQ::Object);

sub init {
    my $class = shift;

    my @Users  = ();
    my @Queues = ();
    my @Routes = ();


    my $Object = { data => {} };
    my $closure = EnQ::Object::_init($Object);

    return bless $closure, $class;
}

sub new {
    my $self = shift;
    
}

1;
