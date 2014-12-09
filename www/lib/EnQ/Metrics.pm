package EnQ::Metrics;
use Mojo::Base 'Mojolicious::Controller';

sub main {
  my $self = shift;
  my $agents = int(rand()*25);
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
