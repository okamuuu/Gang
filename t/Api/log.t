#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use Test::More;
use Test::Exception;
use Path::Class::File;
use File::Temp ();

BEGIN { 
    use_ok('Gang::Api::Log'); 
}

subtest 'log' => sub {
    
    my $tmp_file = Path::Class::File->new( scalar File::Temp::tmpnam );

    my $log = Gang::Api::Log->new(log_path=>$tmp_file->stringify);    
    $log->set_status_msgs('hogehoge');
    $log->end();
    
    my @lines = $tmp_file->slurp(chomp=>1);
    like $lines[1], qr/\[\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\] hogehoge \( [\.\d]+ sec \)/;
};

done_testing;

