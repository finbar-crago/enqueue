#!/usr/bin/env perl
use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use Test::Simple tests => 3;
use EnQ;

my $EnQ = EnQ->new({config_file => "$FindBin::Bin/../misc/sample_config.yml"});
my $u0 = $EnQ->Obj('User');
my $u1 = $EnQ->Obj('User');

$u0->Data({uid=>'100', name=>'finbar', extn=>'5001', pass=>'testPass'});

ok(($u0->Push())           ,"Push Data");
ok(($u1->Pull('100'))      ,"Pull Data");
ok(($u1->name eq 'finbar'), "Good Data");
