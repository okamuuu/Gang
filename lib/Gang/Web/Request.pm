package Gang::Web::Request;
use strict;
use warnings;
use base qw/Plack::Request/;
use Hash::MultiValue;

# The code was taken from Amon2::Web::Request
sub body_parameters {
    my ($self) = @_;
    $self->_decode_parameters($self->SUPER::body_parameters());
}

sub query_parameters {
    my ($self) = @_;
    $self->_decode_parameters($self->SUPER::query_parameters());
}

sub _decode_parameters {
    my ($self, $stuff) = @_;

    my @flatten = $stuff->flatten();
    my @decoded;
    while ( my ($k, $v) = splice @flatten, 0, 2 ) {
        ### use only utf8
        push @decoded, Encode::decode('utf8', $k), Encode::decode('utf8', $v);
    }
    
    return Hash::MultiValue->new(@decoded);
}

1;
