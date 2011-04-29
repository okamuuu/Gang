#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Path::Class ();
use File::Temp ();

BEGIN { use_ok 'Gang::Path' }

subtest 'concatenate some files and pipe it to temp file' => sub {

    my $test1_file = Gang::Path->tmp_file;
    my $test2_file = Gang::Path->tmp_file;

    $test1_file->openw->print("hoge\nfuga");
    $test2_file->openw->print('piyo');

    my $tmp_file =
      Gang::Path->concatenate_to_tmp_file( $test1_file, $test2_file );

    is_deeply( [$tmp_file->slurp(chomp=>1)], ['hoge','fuga', 'piyo']);

};

done_testing;

