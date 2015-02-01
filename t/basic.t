#!/usr/bin/env perl
use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use Test::Simple tests => 12;
use EnQ;

my $EnQ = EnQ->new({config_file => "$FindBin::Bin/../enqueue.yml"});
my $t0 = $EnQ->Obj('Test');
my $t1 = $EnQ->Obj('Test');

ok(defined $EnQ , "EnQ->init() OK");
ok($EnQ->isa('EnQ'), "isa == EnQ");

ok($EnQ->{config}{db}{type} eq 'SQLite', "load config file");
ok($EnQ->{'Obj'}{'Test'}{'db'}{'key'} eq 'id', "ObjInit _load call");

ok($t0->id('test')  ,"Set field");
ok($t0->id eq 'test',"Get field");

ok($t0->regex('abc')  ,"Pass regex");
ok(!$t0->regex('123') ,"Fail regex");
ok($t0->regex eq 'abc',"Get regex data");

ok($t1->id eq '',"Check Leaks");

ok($t1->Data({id=>'t1'})    ,"Data Set");
ok({$t1->Data}->{id} eq 't1',"Data Set");
