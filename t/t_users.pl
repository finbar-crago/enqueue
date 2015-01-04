#!/usr/bin/env perl
use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use Test::Simple tests => 7;
use EnQ;

my $EnQ = EnQ->init();
my $u = $EnQ->new('Users');

ok(defined $u , "EnQ->new('Users') OK");
ok($u->isa('EnQ::Users'), "isa == EnQ::Users" );

ok($u->uid("finbar"), "set uid");
ok($u->extn("12345"), "set extn");

ok($u->uid eq 'finbar', "get uid");
ok($u->extn eq '12345', "get extn");

ok(!$u->extn("ABCD"), "set bad extn");
