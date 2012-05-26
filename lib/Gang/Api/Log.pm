package Gang::Api::Log;
use strict;
use warnings;
use Gang::Api::Msg;
use Gang::Api::DebugMsg;
use Class::Accessor::Lite 0.05 ( 
    ro => [qw/log_path/],
    rw => [qw/error_msg status_msg debug_msg/] );

sub new {
    my ($class, %args) = @_;
    
    bless {
        log_path   => $args{log_path},
        status_msg => Gang::Api::Msg->new,
        error_msg  => Gang::Api::Msg->new,
        debug_msg  => Gang::Api::DebugMsg->new,
    }, $class;
}

sub set_status_msgs {
    my ( $self, @new_msgs ) = @_;
    $self->status_msg->set_msgs(@new_msgs);
    $self->debug_msg->set_msgs(@new_msgs);
}

sub set_error_msgs {
    my ( $self, @new_msgs ) = @_;
    $self->error_msg->set_msgs(@new_msgs);
    $self->debug_msg->set_msgs(@new_msgs);
}

sub set_debug_msgs {
    my ( $self, @new_msgs ) = @_;
    $self->debug_msg->set_msgs(@new_msgs);
}

sub end {
    my $self = shift;
 
    if ( $self->log_path() and $self->debug_msg->has_msgs() ) {

        my $fh = IO::File->new( $self->log_path(), 'a');
       
        $fh->print( '-' x 10, "\n" );
        $fh->print($_) for map { "$_\n" } $self->debug_msg->get_msgs();
        $fh->print("\n");
        $fh->close;
    }
    elsif ( $self->debug_msg->has_msgs() ) {
        warn $_ for $self->debug_msg->get_msgs(); 
    }
    else {
        return;
    }

} 

sub DESTROY { $_[0]->end(); }

1;

