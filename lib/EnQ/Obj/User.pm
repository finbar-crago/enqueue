package EnQ::Obj::User;
use strict;
use warnings;

use Digest;

use parent qw(EnQ::Object);

our $Object = {
    def => {
	'uid'  => EnQ::Object::Field(),
	'name' => EnQ::Object::Field(),
	'extn' => EnQ::Object::Field('REGEX',{regex =>'^[0-9]+$'}),
	'pass' => EnQ::Object::Field('WRITE|REGEX|CB',{regex=>'.{8}', cb=>\&hashPass}),
    },
    db => {
	key   => 'uid',
	table => 'users',
	setup => 'CREATE TABLE users (uid TEXT PRIMARY KEY, name TEXT, extn TEXT, pass TEXT)',
    },
};

sub hashPass {
    my $self = shift;
    my ($pass) = @_;
    my $salt;
    open(RAND, '/dev/urandom');
    read(RAND, $salt, 16);
    close(RAND);

    my $c = Digest->new('Bcrypt');
    $c->cost(1);
    $c->salt($salt);
    $c->add($pass);

    return sprintf('%s::%s', unpack('H[32]',$c->salt), $c->hexdigest);
}

sub checkPass {
    my $self = shift;
    my ($pass) = @_;

    my ($salt, $hash) = split /::/, ${$self->_data}->{'pass'};
    my $c = Digest->new('Bcrypt'); $c->cost(1);
    $c->salt(pack('H[32]', $salt));
    $c->add($pass);

    return ($hash eq $c->hexdigest);
}

sub _load {
    my $parent = shift;
    return $Object;
}

1;
