#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'App::Stitcho' );
}

diag( "Testing App::Stitcho $App::Stitcho::VERSION, Perl $], $^X" );
