package Gang::Api::Msg;
use strict;
use warnings;

sub new { return bless { _msgs => [] }, $_[0]; }

sub get_msgs { @{ $_[0]->{_msgs} }  }

sub has_msgs { scalar $_[0]->get_msgs }

sub set_msgs {
    my ( $self, @new_msgs ) = @_; 
    $self->_set_msg($_) for @new_msgs;
}

sub _set_msg { 
    my ( $self, $new_msg ) = @_; 
    $self->{_msgs} = [ $self->get_msgs, $self->_edit_presetting_msg($new_msg) ];
}

sub _edit_presetting_msg { return $_[1] } # hook

1;

