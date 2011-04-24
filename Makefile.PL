use inc::Module::Install;
name 'Gang';
all_from 'lib/Gang.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
