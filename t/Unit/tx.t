#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::Differences;
use FindBin qw($Bin);

BEGIN { use_ok( 'Gang::Unit::TX' ); }

my $tx;

subtest 'new' => sub {
    $tx = Gang::Unit::TX->new( template => 't/template' );
    isa_ok( $tx, 'Gang::Unit::TX' );
};

subtest "render" => sub {

    my $content = $tx->render( 'name.tx', {name=>'Mike'} );

    eq_or_diff $content, <<"_EOF_";
<div id="content">
Hello, Mike!
</div>
_EOF_
};

done_testing;

