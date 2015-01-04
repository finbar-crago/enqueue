#!/usr/bin/env perl
use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use Test::Simple tests => 2;
use EnQ;

my $EnQ = EnQ->init();
ok(defined $EnQ , "EnQ->init() OK");
ok($EnQ->isa('EnQ'), "isa == EnQ");
