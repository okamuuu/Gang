package t::TestUtils;
use strict;
use warnings;
use Gang::Path;
use Test::Groonga;

sub create_test_grn {
    $_[0]->_create( 
        Gang::Path->grn_schema_file,
    );
}

sub create_test_grn_with_10articles {
    $_[0]->_create( 
        Gang::Path->grn_schema_file,
        Gang::Path->grn_test_file_of('load_10articles.grn'),
    );
}

sub _create {
    my ($class, @preloads) = @_;

    my $load_tmp_file = Gang::Path->concatenate_to_tmp_file( @preloads);

    my $grn = Test::Groonga->create(
        protocol => 'http',
        preload  => $load_tmp_file,
    );

    return $grn;
}


1;

