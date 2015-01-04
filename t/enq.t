#!/usr/bin/env perl
use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use Test::Simple tests => 3;
use EnQ;

my $EnQ = EnQ->init({config => "$FindBin::Bin/../misc/sample_config.yml"});

ok(defined $EnQ , "EnQ->init() OK");
ok($EnQ->isa('EnQ'), "isa == EnQ");

ok($EnQ->{db}{type} eq 'SQLite', "load config file");
