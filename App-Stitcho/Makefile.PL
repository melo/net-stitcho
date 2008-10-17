use inc::Module::Install;

name     'App-Stitcho';
all_from 'lib/App/Stitcho.pm';
author   'Pedro Melo <melo@cpan.org>';

build_requires 'Test::More';

auto_install;

WriteAll;

