package EnQ;
use Mojo::Base 'Mojolicious';


sub startup {
  my $self = shift;
  my $r = $self->routes;

  $r->get('/')->to('Dashboard#main');
}

1;
