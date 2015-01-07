#!/usr/bin/env perl
use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use Test::Simple tests => 12;
use EnQ;

my $EnQ = EnQ->new({config_file => "$FindBin::Bin/../misc/sample_config.yml"});
my $u = $EnQ->Obj('User');

ok(defined $u , "EnQ->new('User') OK");
ok($u->isa('EnQ::Obj::User'), "isa == EnQ::Obj::User");

ok($u->uid("finbar"), "set uid");
ok($u->extn("12345"), "set extn");
ok($u->pass("12345678"), "set pass");
ok($u->pass =~/^[0-9a-f]{32}::[0-9a-f]{46}$/, "hash pass");

ok($u->uid eq 'finbar', "get uid");
ok($u->extn eq '12345', "get extn");

ok(!$u->extn("ABCD"), "set bad extn");

my $d = $EnQ->Obj('User');
ok($d->uid ne 'finbar', "check object leaks");

ok($d->Data({uid=>'123', extn=>'456', pass=>'12345678'}), "Object::Data({...})");
ok($d->uid eq '123', "Object::Data({...}) ret");
