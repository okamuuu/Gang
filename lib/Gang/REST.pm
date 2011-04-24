package Gang::REST;
use strict;
use warnings;

sub new { bless {}, $_[0] }

sub list_archives {
    my ( $self, $cond, $attr ) = @_;
    
    return '[[0,1294292470.41307,0.000532663],[[[2],[["_key","ShortText"],["name","ShortText"]],["tasukuchan","グニャラくん"],["OffGao","OffGao"]]]]';    
}

sub show_archive {
    my ( $self, $id ) = @_;

    return '[[0,1294292470.41307,0.000532663],[[[2],[["_key","ShortText"],["name","ShortText"]],["tasukuchan","グニャラくん"],["OffGao","OffGao"]]]]';    
}

sub create_archive {
    my ( $self, $cond ) = @_;

    return '[[0,1294292470.41307,0.000532663],[[[2],[["_key","ShortText"],["name","ShortText"]],["tasukuchan","グニャラくん"],["OffGao","OffGao"]]]]';    
}

sub update_archive {
    my ( $self, $cond ) = @_;

    return '[[0,1294292470.41307,0.000532663],[[[2],[["_key","ShortText"],["name","ShortText"]],["tasukuchan","グニャラくん"],["OffGao","OffGao"]]]]';    
}

sub delete_archive {
    my ( $self, $id ) = @_;
    
    return '[[0,1294292470.41307,0.000532663],[[[2],[["_key","ShortText"],["name","ShortText"]],["tasukuchan","グニャラくん"],["OffGao","OffGao"]]]]';    
}

1;

