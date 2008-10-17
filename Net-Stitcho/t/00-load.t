#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Net::Stitcho' );
}

diag( "Testing Net::Stitcho $Net::Stitcho::VERSION, Perl $], $^X" );
