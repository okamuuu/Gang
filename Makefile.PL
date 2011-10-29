use inc::Module::Install;
use Module::Install::Repository;
use Module::Install::AuthorTests;

all_from 'lib/Gang.pm';
license 'perl';

requires(
    'Plack' => 0,
    'Plack::Middleware::Debug::W3CValidate' => 0.04,
    'Class::Accessor::Lite' => 0.05,
    'Text::Xslate' => 1.5004,
    'Data::Page::Navigation' => 0.06,
    'Router::Simple::Sinatraish' => 0.02,
);

test_requires(
    'Test::More' => 0,
    'Test::TCP' => 1.13,
);

tests 't/*.t t/*/*.t t/*/*/*.t';
recursive_author_tests 'xt';
auto_set_repository;
#auto_include;
WriteAll;
