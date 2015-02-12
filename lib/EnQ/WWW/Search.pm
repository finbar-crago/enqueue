package EnQ::WWW::Search;
use Mojo::Base 'Mojolicious::Controller';

sub List {
    my $self = shift;
    my $Obj  = $self->param('obj');
    my $key  = $self->EnQ->{'Obj'}->{$Obj}->{'db'}->{'key'};

    my $q = $self->param('q') || '1';

    $q =~ s/ eq / = /g;
    $q =~ s/ gt / > /g;
    $q =~ s/ lt / < /g;

    my $list = $self->EnQ->{'DBA'}->QObjData($Obj, $q);
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
