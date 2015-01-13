package EnQ::WWW::Users;
use Mojo::Base 'Mojolicious::Controller';

sub info {
  my $self = shift;
  my $u = $self->EnQ->Obj('User');
  if($u->Pull($self->param('uid')) && !$u->error){
      $self->render(json => {status=>'OK', data=>{$u->Data}});
  } else {
      $self->render(json => {status=>'ERROR', error=>$u->error})
  }
}

sub add {
  my $self = shift;
  my $u = $self->EnQ->Obj('User');

  $u->uid($self->param('uid'));
  $u->name($self->param('name'));
  $u->extn($self->param('extn'));
  $u->pass($self->param('pass'));

  if($u->Push()){
      $self->render(json => {status=>'OK'});
  } else {
      $self->render(json => {status=>'ERROR', error=> $u->error()});
  }
}

sub list {
  my $self = shift;
  my $l = $self->EnQ->Obj('List');
  $self->render(json => { count => $l->type('User'), list => $l->list() }  );
}

1;
