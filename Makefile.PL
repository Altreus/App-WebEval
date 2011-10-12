use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'App::WebEval',
    AUTHOR              => q{Altreus <altreus@cpan.org>},
    VERSION_FROM        => 'lib/App/WebEval.pm',
    ABSTRACT_FROM       => 'lib/App/WebEval.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Web::Simple' => 0.010,
        'App::EvalServer' => 0.08,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'App-WebEval-*' },
);
