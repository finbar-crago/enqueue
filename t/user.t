#!/usr/bin/env perl
use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use Test::Simple tests => 7;
use EnQ;

my $EnQ = EnQ->init();
my $u = $EnQ->new('User');

ok(defined $u , "EnQ->new('User') OK");
ok($u->isa('EnQ::User'), "isa == EnQ::User");

ok($u->uid("finbar"), "set uid");
ok($u->extn("12345"), "set extn");

ok($u->uid eq 'finbar', "get uid");
ok($u->extn eq '12345', "get extn");

ok(!$u->extn("ABCD"), "set bad extn");