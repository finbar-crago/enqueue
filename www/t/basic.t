use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('EnQ::WWW');
$t->get_ok('/')->status_is(200);
$t->get_ok('/api/user/123456')->status_is(200)->json_is('/uid' => '123456');

done_testing();
