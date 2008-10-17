#!perl -T

use strict;
use warnings;
use Test::More tests => 7;
use Test::Exception;

BEGIN {
	use_ok( 'Net::Stitcho' );
}

my ($x, $z, $w);

lives_ok sub {
  my $args = {
    x => 1,
    z => 2,
    w => 3,
  };
  ($x, $z, $w) = Net::Stitcho::_req_params($args, qw( x z w ));
};

is($x, 1);
is($z, 2);
is($w, 3);

throws_ok sub {
  my $args = {
    x => 1,
    z => 2,
  };
  ($x, $z, $w) = Net::Stitcho::_req_params($args, qw( x z w ));
}, qr//;

throws_ok sub {
  Net::Stitcho::_req_params();
}, qr/FATAL: hashref is required as first argument, /;

