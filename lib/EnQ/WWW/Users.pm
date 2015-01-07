package EnQ::WWW::Users;
use Mojo::Base 'Mojolicious::Controller';

sub info {
  my $self = shift;
  my $u = $self->EnQ->Obj('User');
  $u->Pull($self->param('uid'));
  $self->render(json => $u->Data);
}

sub add {
  my $self = shift;
  my $u = $self->EnQ->Obj('User');

  $u->uid($self->param('uid'));
  $u->name($self->param('name'));
  $u->extn($self->param('extn'));
  $u->pass($self->param('pass'));

  $u->Push();

  $self->render(json => {});
}

sub list {
  my $self = shift;
  $self->render(json => {});
}

1;
