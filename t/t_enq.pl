#!/usr/bin/env perl
use strict;
use warnings;

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use EnQ;
use EnQ::Users;

$\ = "\n"; $, = "\t";

use Data::Dumper;

my $e = EnQ->init();
my $u = $e->new('Users');
$u->uid("Test");
print Dumper $u->data();
