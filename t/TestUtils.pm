package t::TestUtils;
use strict;
use warnings;
use Gang::Path;
use Test::Groonga;

sub create_test_grn_with_10articles {
    my $class = shift;

    my $load_tmp_file = Gang::Path->concatenate_to_tmp_file(
        Gang::Path->grn_schema_file,
        Gang::Path->grn_test_file_of('load_10articles.grn'),
    );

    my $grn = Test::Groonga->create(
        protocol => 'http',
        preload  => $load_tmp_file,
    );

    my $url = "http://127.0.0.1:@{[ $grn->port ]}/d/status";
    my $res = LWP::UserAgent->new()->get($url);
    warn $res->code;
    warn $res->content;

    return $grn;
}

1;

