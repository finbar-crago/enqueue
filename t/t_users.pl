#!/usr/bin/env perl
use strict;
use warnings;

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use EnQ::Users
$\ = "\n"; $, = "\t";

my $u = EnQ::Users->new(); 
$u->uid("finbar") or print $u->is_error();
$u->extn("12345") or print $u->is_error();

print "user:", $u->uid;
print "extn:", $u->extn;

$u->extn("ABCD") or print $u->is_error();

$u->badName("Hello") or print $u->is_error();
print $u->badName;# or print $u->is_error();

print $u->confSip();

use Data::Dumper;
my $p = EnQ::Users->new();
$p->pull("test");
print $p->uid;

print Dumper $p->data();
