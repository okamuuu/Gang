package Gang::Path;
use strict;
use warnings;
use Cwd ();
use Path::Class ();

sub grn_schema_file {
    Path::Class::File->new( Cwd::cwd, 'groonga', 'schema', 'gang.grn' );  
}

1;

