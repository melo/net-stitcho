#!perl -T

use strict;
use warnings;
use Test::More;
use Test::Exception;
use Encode qw( decode );

my ($id, $key, $rcpt) = @ENV{qw( STITCHO_PARTNER STITCHO_KEY STITCHO_RCPT)};

plan skip_all => 'Set STITCHO_PARTNER, STITCHO_KEY and STITCHO_RCPT to test live'
  unless $id && $key && $rcpt;

plan tests => 6;

require Net::Stitcho;
my $api = Net::Stitcho->new({
  id  => $id,
  key => $key,
});

my $args = {
  email   => $rcpt,
  title   => 'Hello!',
  message => 'Have a nice day & all!',
  url     => 'http://www.stitcho.com/',
  icon    => 53,
};

my $error;
lives_ok sub { $error = $api->send($args) }, "send() lived";
ok(!defined($error), "API returned ".($error || 200));


$args->{title} = 'Friendly advice';
$args->{message} = decode('utf8', 'A  a day keeps the borg away!');

lives_ok sub { $error = $api->send($args) }, "send() utf8 lived";
ok(!defined($error), 'API returned '.($error || 200). ' for utf8 content');


lives_ok sub { $error = $api->signup($args) }, "signup() lived";
ok(!defined($error), "API returned ".($error || 200));
