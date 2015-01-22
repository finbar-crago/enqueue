use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('EnQ::WWW');
$t->get_ok('/')->status_is(200);
$t->post_ok('/api/users/JsonAdd' => json => {uid=>'JsonAdd', name=>'Json Add', extn=>'5055'})->status_is(200);
$t->post_ok('/api/users/FormAdd' => form => {uid=>'FormAdd', name=>'Form Add', extn=>'5056'})->status_is(200);
$t->get_ok('/api/users/JsonAdd')->status_is(200)->json_is('/data/name' => 'Json Add');
$t->get_ok('/api/users/FormAdd')->status_is(200)->json_is('/data/name' => 'Form Add');

done_testing();
