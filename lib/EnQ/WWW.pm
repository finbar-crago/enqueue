package EnQ::WWW;
use Mojo::Base 'Mojolicious';
use EnQ;

use FindBin;

sub startup {
  my $self = shift;
  my $r = $self->routes;

  my $EnQ = EnQ::->new({config_file => $FindBin::Bin =~ s|(.+/enqueue).+|$1/enqueue.yml|r});
  $self->helper(EnQ => sub { return $EnQ });

  $r->get('/' => sub { shift->reply->static('index.html'); })->name('Static');

  $r   ->get('/EnQ/@/:obj')     ->to('Search#List' )->name('SearchList' );
  $r  ->post('/EnQ/@/:obj')     ->to('Search#Query')->name('SearchQuery');

  $r   ->get('/EnQ/!/:obj/:uid')->to('Basic#Pull' )->name('BasicPull' );
  $r  ->post('/EnQ/!/:obj/:uid')->to('Basic#Push' )->name('BasicPush' );
  $r->delete('/EnQ/!/:obj/:uid')->to('Basic#Purge')->name('BasicPurge');

}

1;
