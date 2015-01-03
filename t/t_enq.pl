#!/usr/bin/env perl
use strict;
use warnings;

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use EnQ;
use EnQ::Users;

$\ = "\n"; $, = "\t";

my $e = EnQ->init();
my $u = $e->new('Users');
