use inc::Module::Install;

# Basic MetaData
name     'Net-Stitcho';
all_from 'lib/Net/Stitcho.pm';
repository 'http://github.com/melo/net-stitcho';


build_requires 'Test::More';

WriteAll;



