#!perl -T

use strict;
use warnings;
use Test::More tests => 13;
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

my $uri;
lives_ok sub {
  $uri = $api->send_uri({
    email   => 'melo@cpan.org',
    title   => 'Hello!',
    message => 'Have a nice day & all!',
    url     => 'http://www.stitcho.com/',
  });
};
is($uri, 'http://api.stitcho.com/api/partner/send?p=1&md5=&4809188f41ad2613f4c240b72d97604c&t=&Hello!&m=&Have%20a%20nice%20day%20%26%20all!&u=&http%3A%2F%2Fwww.stitcho.com%2F&s=838b98ea122a5055e418128813d8b91e');

lives_ok sub {
  $uri = $api->send_uri({
    email   => 'melo@cpan.org',
    title   => 'Hello!',
    message => 'Have a nice day & all!',
    url     => 'http://www.stitcho.com/',
    icon    => 53,
  });
};
is($uri, 'http://api.stitcho.com/api/partner/send?p=1&i=53&md5=&4809188f41ad2613f4c240b72d97604c&t=&Hello!&m=&Have%20a%20nice%20day%20%26%20all!&u=&http%3A%2F%2Fwww.stitcho.com%2F&s=5e7253b128b86b72d7770309a609ecc9');


# Test bad API usage
throws_ok sub { $api->send_uri() },
          qr{FATAL: hashref is required as first argument};

throws_ok sub { $api->send_uri({}) },
          qr{FATAL: required parameter 'email' is missing};
throws_ok sub { $api->send_uri({ email => 'a' }) },
          qr{FATAL: required parameter 'title' is missing};
throws_ok sub { $api->send_uri({ email => 'a', title => 'a' }) },
          qr{FATAL: required parameter 'message' is missing};
throws_ok sub { $api->send_uri({ email => 'a', title => 'a', message => 'm' }) },
          qr{FATAL: required parameter 'url' is missing};
