package EnQ::WWW::Dashboard;
use Mojo::Base 'Mojolicious::Controller';

sub main {
  my $self = shift;
  $self->render(msg => '...');
}

1;
