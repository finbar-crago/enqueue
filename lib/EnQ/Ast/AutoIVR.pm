package EnQ::Ast::AutoIVR;
use strict;
use warnings;
$\ = "\n";

sub conf_queues {
    my $y = shift;
    my $ID = uc $y->{'Name'};

    print "[$ID](!)";
    print for(@{$y->{'QueueConf'}});
    print '';

    for(@{$y->{'Queue'}}){
        print '['.$ID.'-'.$_->{'ID'}.'](base,'.$ID.')';
        print for(@{$_->{'Conf'}});
    }
    print '';
}

sub conf_extensions_landing {
    my $y = shift;
    my $ID = uc $y->{'Name'};

    for(@{$y->{'Landing'}}){
        print 'exten => '.$_.',1,Answer';
        print 'exten => '.$_.',2,GoSub(IVR-'.$ID.')';
        print 'exten => '.$_.',3,Hangup';
    }

    print '';
}

sub conf_extensions_agent {
    my $y = shift;
    my $ID = uc $y->{'Name'};

    for(@{$y->{'Queue'}}){
        print 'exten => *'.$_->{'Extn'}.',1,Answer';
        print 'exten => *'.$_->{'Extn'}.',2,AddQueueMember('.$ID.'-'.$_->{'ID'}.')';
        print 'exten => *'.$_->{'Extn'}.',3,Hangup';

        print 'exten => #'.$_->{'Extn'}.',1,Answer';
        print 'exten => #'.$_->{'Extn'}.',2,RemoveQueueMember('.$ID.'-'.$_->{'ID'}.')';
        print 'exten => #'.$_->{'Extn'}.',3,Hangup';
    }
    print '';
}

sub conf_extensions_default {
    my $y = shift;
    my $ID = uc $y->{'Name'};

    conf_extensions_landing($y);

    print 'exten => '.$y->{'Extn'}.',1,Answer';
    print 'exten => '.$y->{'Extn'}.',2,GoSub(IVR-'.$ID.')';
    print 'exten => '.$y->{'Extn'}.',3,Hangup';

    for(@{$y->{'Queue'}}){
	print 'exten => '.$_->{'Extn'}.',1,Answer';
        print 'exten => '.$_->{'Extn'}.',2,Queue('.$ID.'-'.$_->{'ID'}.')';
        print 'exten => '.$_->{'Extn'}.',3,Hangup';
    }

    for(@{$y->{'Xfer'}}){
        next if !$_->{'Extn'};
        print 'exten => '.$_->{'Extn'}.',1,Answer';
        print 'exten => '.$_->{'Extn'}.',2,Dial(Local/',$_->{'To'},')';
        print 'exten => '.$_->{'Extn'}.',3,Hangup';
    }

    print '';
}

sub conf_extensions_global {
    my $y = shift;
    my $ID = uc $y->{'Name'};

    my $pc = 1;
    my $hello = $y->{'IVR'}->{'Play'}->{'Hello'};
    print "[IVR-$ID]";
    print 'exten => s,'.$pc++.",GoSub(IVR-TIME-$ID)";
    print 'exten => s,'.$pc++.",Playback($hello)";
    print 'exten => s,'.$pc++.",GoTo(IVR-OPT-$ID,s,1)";
    print '';

    $pc = 1;
    print "[IVR-TIME-$ID]";
    print 'exten => s,'.$pc++.',ExecIfTime(',$y->{'Hours'},',mon-fri?Return)';
    print 'exten => s,'.$pc++.',ExecIfTime(',$y->{'HoursWE'},',sat-sun?Return)';
    print 'exten => s,'.$pc++.",GoTo(EXIT-CLOSED-$ID,s,1)";
    print '';

    $pc = 1;
    my $prompts = $y->{'IVR'}->{'Play'}->{'Prompts'};
    print "[IVR-OPT-$ID]";
    print 'exten => s,',$pc++,',Read(I,',$prompts,',1,,4,7)';

    my @OPT;
    $OPT[$_->[0]] = $_->[1] for @{$y->{'IVR'}->{'DTMF'}};
    for(0..9){
	my $i = defined($OPT[$_])?"SUB-$ID-".$OPT[$_]:"IVR-OPT-$ID";
	print 'exten => s,'.$pc++.",Set(HASH(OPT,$_)=$i)";
    }
    print 'exten => s,'.$pc++.",Set(HASH(OPT,#)=IVR-OPT-$ID)";
    print 'exten => s,'.$pc++.",Set(HASH(OPT,*)=IVR-OPT-$ID)";
    print 'exten => s,'.$pc++.",Set(HASH(OPT,)=SUB-$ID-".$y->{'DefaultQueue'}.')';

    print 'exten => s,'.$pc++.',GoSub(${HASH(OPT,${I})},PRIVACY)';
    print 'exten => s,'.$pc++.",GoTo(EXIT-FAILED-$ID,s,1)";
    print '';

    for(@{$y->{'Queue'}}){
	my $pc = 1;
	my $Privacy = $y->{'IVR'}->{'Play'}->{'Privacy'};
	print "[SUB-$ID-".$_->{'ID'}."]";
	print 'exten => s,'.$pc++.',Set(CALLERID(name)=',$y->{'LongName'},': ',$_->{'Name'},')';
	print 'exten => s,'.$pc++.',ExecIf($["${ARG1}" = "PRIVACY"]?Playback('.$Privacy.'))';
	print "exten => s,".$pc++.",Queue($ID-".$_->{'ID'}.")";
	print "exten => s,".$pc++.",Return";
	print '';
    }

    for(@{$y->{'Xfer'}}){
	print "[SUB-$ID-".$_->{'ID'}."]";
	print "exten => s,1,Dial(LOCAL/".$_->{'To'}.")";
	print "exten => s,2,Return";
	print '';
    }

    $pc = 1;
    print "[EXIT-CLOSED-$ID]";
    print 'exten => s,'.$pc++.",Hangup";
    print '';

    $pc = 1;
    print "[EXIT-FAILED-$ID]";
    print 'exten => s,'.$pc++.",Hangup";
    print '';
}

1;
