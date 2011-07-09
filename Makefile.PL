use inc::Module::Install;
name 'Gang';
all_from 'lib/Gang.pm';

# requires '';
requires 'Plack::Middleware::Debug::W3CValidate' => 0.04
# requires 'Smart::Args' => 0.10;
requires 'Class::Accessor::Lite' => 0.05;

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
test_requires 'Test::TCP' => 1.13;
auto_set_repository;
auto_include;
WriteAll;
