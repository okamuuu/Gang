package t::TestUtils;
use strict;
use warnings;
use Gang::Path;
use Test::Groonga 0.06;

sub create_test_grn {
    $_[0]->_create( 
        Gang::Path->grn_schema_file,
        Gang::Path->grn_data_file,
    );
}

sub create_test_grn_with_20articles {
    $_[0]->_create( 
        Gang::Path->grn_schema_file,
        Gang::Path->grn_test_file_of('load_keywords.grn'),
        Gang::Path->grn_test_file_of('load_20articles.grn'),
    );
}

sub _create {
    my ($class, @preloads) = @_;

    my $load_tmp_file = Gang::Path->concatenate_to_tmp_file( @preloads);

    return = Test::Groonga->create(
        default_command_version => 2,
        protocol => 'http',
        preload  => $load_tmp_file,
    );
}

1;

