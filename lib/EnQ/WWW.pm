package EnQ::WWW;
use Mojo::Base 'Mojolicious';


sub startup {
  my $self = shift;
  my $r = $self->routes;

  $r->get('/')->to('Dashboard#main');

  $r->get('/api/metrics')->to('Metrics#main');

  $r->get('/api/user')->to('Users#list');
  $r->get('/api/user/:uid')->to('Users#info');
  $r->post('/api/user')->to('Users#new');

}

1;
