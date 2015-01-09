use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('EnQ::WWW');
$t->get_ok('/')->status_is(200);
$t->post_ok('/api/user/' => form => {uid=>'456789', name=>'TestUser', extn=>'123'})->status_is(200);
$t->get_ok('/api/user/456789')->status_is(200)->json_is('/data/name' => 'TestUser');

done_testing();
