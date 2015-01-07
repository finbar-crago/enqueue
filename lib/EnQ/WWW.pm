package EnQ::WWW;
use Mojo::Base 'Mojolicious';
use EnQ;

use FindBin;

sub startup {
  my $self = shift;
  my $r = $self->routes;

  my $EnQ = EnQ::->new({config_file => $FindBin::Bin =~ s|(.+/enqueue).+|$1/misc/sample_config.yml|r});
  $self->helper(EnQ => sub { return $EnQ });

  $r->get('/')->to('Dashboard#main');

  $r->get('/api/metrics')->to('Metrics#main');

  $r->get('/api/user')->to('Users#list');
  $r->get('/api/user/:uid')->to('Users#info');
  $r->post('/api/user')->to('Users#add');

}

1;
