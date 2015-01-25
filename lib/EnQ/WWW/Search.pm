package EnQ::WWW::Search;
use Mojo::Base 'Mojolicious::Controller';

sub List {
    my $self = shift;
    my $list = $self->EnQ->{'DBA'}->QObjData($self->param('obj'));
    $self->render(json => { status => $list?'ok':'error', data => $list });
}

sub Query {
    my $self = shift;
    $self->render(json => { status => 'to-do' });
}

1;
