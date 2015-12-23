#!plackup

use strict;
use warnings;
use feature qw(state);

use JSON;
use Plack::Request;
use Plack::Response;

sub {
  my ($env) = @_;
  my $req = Plack::Request->new($env);
  my $res = Plack::Response->new(200);
  state $json = JSON->new->ascii(1)->canonical(1)->pretty(1);
  $res->content_type('application/vnd.psgi.v1+json');
  $res->body($json->encode(
    {
      v           => 1,
      address     => $req->address,
      remote_host => $req->remote_host,
      protocol    => $req->protocol,
      request_uri => $req->request_uri,
      path_info   => $req->path_info,
      path        => $req->path,
    }
  ));
  return $res->finalize;
};

# vim:set ft=perl:
