package EnQ::WWW::Basic;
use Mojo::Base 'Mojolicious::Controller';

sub List {
  my $self = shift;
  my $l = $self->EnQ->Obj('List');
  $self->render(json => { status => 'ok', count => $l->type( $self->param('obj') ), list => $l->list() }  );
}

sub Pull {
  my $self = shift;
  my $u = $self->EnQ->Obj($self->param('obj'));
  if($u->Pull($self->param('uid')) && !$u->error){
      $self->render(json => {status=>'ok', data=>{$u->Data}});
  } else {
      $self->render(json => {status=>'error', error=>$u->error})
  }
}

sub Push {
  my $self = shift;
  my $u = $self->EnQ->Obj($self->param('obj'));

  if(defined($self->req->json) && ($self->req->json->{'uid'} =~ /^[a-z0-9]{3,}/i)){

      $u->Data($self->req->json);

  } else {
      $self->render(json => {status=>'error', error=> 'Missing or bad uid.'});
      return;
  }

  if($u->Push()){
      $self->render(json => {status=>'ok'});
  } else {
      $self->render(json => {status=>'error', error=> $u->error()});
  }

}

sub Purge {
  my $self = shift;
  my $u = $self->EnQ->Obj($self->param('obj'));
  $u->uid($self->param('uid'));
  if($u->Purge() && !$u->error){
      $self->render(json => {status=>'ok'});
  } else {
      $self->render(json => {status=>'error', error=> $u->error()});
  }
}

1;
