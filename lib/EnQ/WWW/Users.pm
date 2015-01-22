package EnQ::WWW::Users;
use Mojo::Base 'Mojolicious::Controller';

sub main {
    my $self = shift;
    $self->render();
}

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

  if(defined($self->req->json) && ($self->req->json->{'uid'} =~ /^[a-z0-9]{3,}/i)){

      $u->Data($self->req->json);

  }  elsif(defined($self->param('uid')) && ($self->param('uid') =~ /^[a-z0-9]{3,}/i)){

      $u-> uid($self->param( 'uid'));
      $u->name($self->param('name'));
      $u->extn($self->param('extn'));
      $u->pass($self->param('pass'));

  } else {
      $self->render(json => {status=>'ERROR', error=> 'Missing or bad uid.'});
      return;
  }

  if($u->Push()){
      $self->render(json => {status=>'OK'});
  } else {
      $self->render(json => {status=>'ERROR', error=> $u->error()});
  }

}

sub del {
  my $self = shift;
  my $u = $self->EnQ->Obj('User');
  if($u->Purge($self->param('uid')) && !$u->error){
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
