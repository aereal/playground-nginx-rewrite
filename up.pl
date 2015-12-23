#!/usr/bin/env perl

use strict;
use warnings;

use Plack::Runner;
use Proclet;

my $proclet = Proclet->new(
  color       => 1,
  exec_notice => 0,
);

$proclet->service(
  tag => 'psgi',
  code => sub {
    my $runner = Plack::Runner->new;
    $runner->parse_options('--reload', '--app', './app.psgi');
    $runner->run;
  },
);

$proclet->service(
  tag => 'proxy',
  code => ['/usr/local/bin/nginx', '-p', '.', '-c', './nginx.conf'],
);

$proclet->run;
