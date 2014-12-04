package EnQ::Live;
use Mojo::Base 'Mojolicious::Controller';

sub main {
  my $self = shift;
  $self->render(json => {agents => 6});
}

1;
