package EnQ::WWW::Search;
use Mojo::Base 'Mojolicious::Controller';

sub List {
    my $self = shift;
    $self->render(json => { status => 'to-do' });
}

sub Query {
    my $self = shift;
    $self->render(json => { status => 'to-do' });
}

1;
