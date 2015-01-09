#!/usr/bin/env perl
use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use Test::Simple tests => 2;
use EnQ;

my $EnQ = EnQ->new({config_file => "$FindBin::Bin/../misc/sample_config.yml"});
my $l = $EnQ->Obj('List');

ok($l->type('User'),"Get Type");
ok($l->list        ,"See List");
