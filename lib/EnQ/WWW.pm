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

  $r   ->get('/EnQ/@/:obj')     ->to('Search#List' );
  $r  ->post('/EnQ/@/:obj')     ->to('Search#Query');

  $r   ->get('/EnQ/!/:obj/:uid')->to('Basic#Pull' );
  $r  ->post('/EnQ/!/:obj/:uid')->to('Basic#Push' );
  $r->delete('/EnQ/!/:obj/:uid')->to('Basic#Purge');

}

1;
