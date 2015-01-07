#!/usr/bin/env perl
use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use Test::Simple tests => 4;
use EnQ;

my $EnQ = EnQ->new({config_file => "$FindBin::Bin/../misc/sample_config.yml"});

ok(defined $EnQ , "EnQ->init() OK");
ok($EnQ->isa('EnQ'), "isa == EnQ");

ok($EnQ->{config}{db}{type} eq 'SQLite', "load config file");
ok($EnQ->{'Obj'}{'User'}{'db'}{'key'} eq 'uid', "ObjInit _load call");
