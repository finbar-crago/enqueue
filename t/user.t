#!/usr/bin/env perl
use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use Test::Simple tests => 6;
use EnQ;

my $EnQ = EnQ->new({config_file => "$FindBin::Bin/../enqueue.yml"});
my $u = $EnQ->Obj('User');

ok(defined $u , "EnQ->new('User') OK");
ok($u->isa('EnQ::Obj::User'), "isa == EnQ::Obj::User");

ok($u->pass("12345678"), "set pass");
ok(${$u->_data}->{'pass'} =~/^[0-9a-f]{32}::[0-9a-f]{46}$/, "hash pass");

ok($u->checkPass("12345678"), "checkPass (good)");
ok(!$u->checkPass("abc123"), "checkPass (bad)");
