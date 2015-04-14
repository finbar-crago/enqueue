package EnQ::Ast::Groups;
$\ = "\n";

sub conf_extensions_agent {
    my $y = shift;
    for(keys $y->{'Groups'}){
	my $extn = $_;
	for(@{ $y->{'Groups'}->{$_} }){
	    print 'exten => *'.$extn.',1,Answer';
	    print 'exten => *'.$extn.',2,AddQueueMember('.$_->[0].'-'.$_->[1].')';
	    print 'exten => *'.$extn.',3,Hangup';

	    print 'exten => #'.$extn.',1,Answer';
	    print 'exten => #'.$extn.',2,RemoveQueueMember('.$_->[0].'-'.$_->[1].')';
	    print 'exten => #'.$extn.',3,Hangup';
	}
    }
}

sub conf_queues {}
sub conf_extensions_landing {}
sub conf_extensions_global {}
sub conf_extensions_default {}

1;
