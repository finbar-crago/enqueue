package EnQ;
use Mojo::Base 'Mojolicious';


sub startup {
  my $self = shift;
  my $r = $self->routes;

  $r->get('/')->to('Dashboard#main');

  $r->get('/api/live')->to('Live#main');
}

1;
