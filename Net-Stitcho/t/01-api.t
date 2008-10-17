#!perl -T

use strict;
use warnings;
use Test::More tests => 4;
use Test::Exception;

BEGIN {
	use_ok( 'Net::Stitcho' );
}

my $api = Net::Stitcho->new({
  id  => 1,
  key => 'abcdfeghijklmnop',
});
isa_ok($api, 'Net::Stitcho');

is($api->id, 1);
is($api->key, 'abcdfeghijklmnop');
