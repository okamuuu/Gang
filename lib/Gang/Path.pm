package Gang::Path;
use strict;
use warnings;
use Cwd ();
use File::Temp ();
use Path::Class ();

sub grn_schema_file {
    Path::Class::File->new( Cwd::cwd, 'groonga', 'schema.grn' );  
}

sub grn_data_file {
    Path::Class::File->new( Cwd::cwd, 'groonga', 'data.grn' );  
}

sub grn_test_file_of {
    my ( $class, $target ) = @_;

    Path::Class::File->new( Cwd::cwd, 't', 'groonga', $target );
}

sub tmp_file {
    my $tmp = File::Temp::tmpnam();
    return Path::Class::File->new( $tmp );
}

sub concatenate_to_tmp_file {
    my ( $class, @files ) = @_;

    Carp::croak("This is NOT Path::Class::File")
      for grep { ref $_ ne 'Path::Class::File' } @files;

    my $tmp_file = $class->tmp_file;
    
    my $fh = $tmp_file->openw;
    $fh->print( $_, "\n" ) for map { $_->slurp(chomp=>1) } @files;
    
    return $tmp_file;
}

1;

