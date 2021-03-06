use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('EnQ::WWW');
$t-> get_ok('/')->status_is(200);
$t->post_ok('/EnQ/!/User/JsonAdd' => json => {uid=>'JsonAdd', name=>'Json Add', extn=>'5055'})->status_is(200);
$t-> get_ok('/EnQ/!/User/JsonAdd')->status_is(200)->json_is('/data/name' => 'Json Add');

done_testing();
