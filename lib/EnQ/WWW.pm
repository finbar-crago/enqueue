package EnQ::WWW;
use Mojo::Base 'Mojolicious';
use EnQ;

use FindBin;

sub startup {
  my $self = shift;
  my $r = $self->routes;

  my $EnQ = EnQ::->new({config_file => $FindBin::Bin =~ s|(.+/enqueue).+|$1/misc/sample_config.yml|r});
  $self->helper(EnQ => sub { return $EnQ });

  $r->get('/' => sub { shift->reply->static('index.html'); });

  $r->get('/api/users')->to('Users#list');
  $r->get('/api/users/:uid')->to('Users#pull');
  $r->post('/api/users/:uid')->to('Users#push');
  $r->delete('/api/users/:uid')->to('Users#purge');


}

1;
