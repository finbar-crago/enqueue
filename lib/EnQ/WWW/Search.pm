package EnQ::WWW::Search;
use Mojo::Base 'Mojolicious::Controller';

sub List {
    my $self = shift;
    my $list = $self->EnQ->{'DBA'}->QObjData($self->param('obj'));
    $self->render(json => { status => $list?'ok':'error', data => $list });
}

sub Query {
    my $self = shift;
    my $q = $self->req->json->{'q'};
    my $list = $self->EnQ->{'DBA'}->QObjData($self->param('obj'), $q);
    $self->render(json => { status => $list?'ok':'error', data => $list });
}

1;
