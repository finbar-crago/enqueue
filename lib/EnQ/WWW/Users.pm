package EnQ::WWW::Users;
use Mojo::Base 'Mojolicious::Controller';
use EnQ::Users;

sub info {
  my $self = shift;
  my $u = EnQ::Users->new();
  $u->get($self->param('uid'));
  $self->render(json => {$self->param('uid')});
}

sub add {
  my $self = shift;
  my $u = EnQ::Users->new();

  $u->name($self->param('uid'));
  $u->name($self->param('name'));
  $u->name($self->param('extn'));
  $u->name($self->param('sipPass'));
  $u->name($self->param('wwwPass'));

  $u->push();

  $self->render(json => {});
}

sub list {
  my $self = shift;
  $self->render(json => {});
}

1;
