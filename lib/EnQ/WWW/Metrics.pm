package EnQ::Metrics;
use Mojo::Base 'Mojolicious::Controller';

sub main {
  my $self = shift;
  my $aTotal = 26;
  my $agents = sprintf("%d/%d", $aTotal-int(rand()*26),$aTotal);
  my $calls = int(rand()*25);
  my $drops = int(rand()*25);
  my $wTime = sprintf("%02d:%02d", int(rand()*59),int(rand()*59));

  $self->render(json => 
      {
	  agents => $agents,
	  calls  => $calls,
	  drops  => $drops,
	  wait   => $wTime,
      });
}

1;
