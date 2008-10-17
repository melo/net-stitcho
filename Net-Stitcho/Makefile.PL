use inc::Module::Install;

name     'Net-Stitcho';
all_from 'lib/Net/Stitcho.pm';
author   'Pedro Melo <melo@cpan.org>';

build_requires 'Test::More';

auto_install;

WriteAll;

