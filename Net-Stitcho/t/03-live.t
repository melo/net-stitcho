#!perl -T

use strict;
use warnings;
use Test::More;
use Test::Exception;

my ($id, $key, $rcpt) = @ENV{qw( STITCHO_PARTNER STITCHO_KEY STITCHO_RCPT)};

plan skip_all => 'Set STITCHO_PARTNER, STITCHO_KEY and STITCHO_RCPT to test live'
  unless $id && $key && $rcpt;

require Net::Stitcho;
my $api = Net::Stitcho->new({
  id  => $id,
  key => $key,
});

my $error;
lives_ok sub {
  $error = $api->send({
    email   => $rcpt,
    title   => 'Hello!',
    message => 'Have a nice day & all!',
    url     => 'http://www.stitcho.com/',
  });
};
ok(!defined($error));
