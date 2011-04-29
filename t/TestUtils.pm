package t::TestUtils;
use strict;
use warnings;
use Gang::Path;
use Test::Groonga;
use LWP::UserAgent;

sub create_test_grn_with_10articles {
    my $class = shift;

    my $grn = Test::Groonga->create(
        protocol => 'http',
        preload  => Gang::Path->grn_schema_file->stringify,
    );

    my $url = "http://127.0.0.1:@{[ $grn->port ]}/d/status";
    my $res = LWP::UserAgent->new()->get($url);
    warn $res->code;
    warn $res->content;

    return $grn;
}

1;

