#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::Exception;
use Path::Class::File;
use File::Temp ();

BEGIN { 
    use_ok('Gang::Api::Msg'); 
    use_ok('Gang::Api::DebugMsg'); 
    use_ok('Gang::Api::Base'); 
}

subtest 'msg' => sub {

    my $msg = Gang::Api::Msg->new;
    isa_ok($msg, "Gang::Api::Msg");
 
    is $msg->has_msgs, 0;
    
    lives_ok { $msg->set_msgs('you send a mail') };
    is $msg->has_msgs, 1;
    is_deeply [ $msg->get_msgs ], ['you send a mail'];
    
    lives_ok { $msg->set_msgs( 'you got a mail', 'you drop the mail' ) };
    is $msg->has_msgs, 3;
    is_deeply [ $msg->get_msgs ], ['you send a mail', 'you got a mail', 'you drop the mail'];
};

subtest 'DebugMsg' => sub {

    my $debug = Gang::Api::DebugMsg->new;
    isa_ok($debug, "Gang::Api::DebugMsg");
    
    lives_ok { $debug->set_msgs('you send a mail') };
    is $debug->has_msgs, 1;
    like [ $debug->get_msgs ]->[0], qr/\[\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\] you send a mail \( [\.\d]+ sec \)/;
};

subtest 'Base' => sub {

    my $tmp_file = Path::Class::File->new( scalar File::Temp::tmpnam );

    my $base = Gang::Api::Base->new(log_path=>$tmp_file->stringify);
    isa_ok($base, "Gang::Api::Base");
    
    lives_ok { $base->set_debug_msgs('debug') };

    undef $base;
    my @lines = $tmp_file->slurp(chomp=>1);
    like $lines[1], qr/\[\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\] debug \( [\.\d]+ sec \)/;
};

done_testing;

