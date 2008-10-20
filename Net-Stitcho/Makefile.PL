use inc::Module::Install;

# Basic MetaData
name     'Net-Stitcho';
all_from 'lib/Net/Stitcho.pm';
repository 'http://github.com/melo/net-stitcho';

# Dependencies
requires 'Class::Accessor::Fast' => 0;
requires 'Carp::Clan'            => 0;
requires 'URI::Escape'           => 0;
requires 'Digest::MD5'           => 0;

build_requires 'Test::More';
build_requires 'Test::Exception';

WriteAll;



