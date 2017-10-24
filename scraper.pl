use strict;
use warnings;

use Mojo::UserAgent;

sub scraper {
  my $ua  = Mojo::UserAgent->new;
  my $res = $ua->get('http://www.4cantoscambio.com.br/')->result;
  if    ($res->is_success)  { print $res->body; }
  elsif ($res->is_error)    { print $res->message; }
  elsif ($res->code == 301) { print $res->headers->location; }
  else                      { print 'Whatever...'; }
}

scraper();
