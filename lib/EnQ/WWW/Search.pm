package EnQ::WWW::Search;
use Mojo::Base 'Mojolicious::Controller';

sub List {
    my $self = shift;
    my $Obj  = $self->param('obj');
    my $key  = $self->EnQ->{'Obj'}->{$Obj}->{'db'}->{'key'};
    my $list = $self->EnQ->{'DBA'}->QObjData($Obj);
    $self->render(json => {
	    status => $list?'ok':'error',
	    info => { name => $Obj ,key => $key },
	    data => $list,
	});
}

sub Query {
    my $self = shift;
    my $q = $self->req->json->{'q'};
    my $list = $self->EnQ->{'DBA'}->QObjData($self->param('obj'), $q);
    $self->render(json => { status => $list?'ok':'error', data => $list });
}

1;
