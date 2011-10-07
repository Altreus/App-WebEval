#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'App::WebEval' ) || print "Bail out!\n";
}

diag( "Testing App::WebEval $App::WebEval::VERSION, Perl $], $^X" );
