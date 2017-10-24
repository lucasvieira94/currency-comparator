use strict;
use warnings;

use Mojo::UserAgent;
use Mojo::DOM;
use Term::ANSIScreen qw(cls);

sub main {
  print "*************************************************************************\n";
  print "\t\tTrabalho de Linguagens de Programacao - Parte II\n";
  print "\t\t\t\tUFRJ - 2017.2\n";
  print "\t\t\t\tLucas Vieira\n";
  print "*************************************************************************\n\n\n";

  choose_currency_type();
}

sub clear_screen {
  my $clear_screen = cls();
  print $clear_screen;
}

sub choose_currency_type {
  print "Choose the currency type:\n\n";

  print "\t1 - Fisical Currencies\n";
  print "\t2 - Crypto Currencies\n\n";
  print "\tPress anything else to exit.\n\n";
  print "Option: ";

  my $choice = <STDIN>;

  if ($choice == 1) {
    fisical_currencies();
  } elsif ($choice == 2) {
    crypto_currencies();
  } else {
    goodbye_message();
  }

  sub fisical_currencies {
    clear_screen();
    print "Fisical currencies\n";
    return 0;
  }

  sub crypto_currencies {
    clear_screen();
    print "Crypto currencies\n";
    crypto_scraper('Bitcoin', 'http://dolarhoje.com/bitcoin-hoje/');
    return 0;
  }

  sub goodbye_message {
    clear_screen();
    print "\t\t\tThanks for using my program! :)\n\n";
    exit();
  }

  sub crypto_scraper {
    my $ua  = Mojo::UserAgent->new;
    my $response_bitcoin = $ua->get(@_[1])->result;
    if    ($response_bitcoin->is_success)  {
      my $dom = Mojo::DOM->new($response_bitcoin->body);
      my @values = $dom->find('input')->map(attr => 'value')->compact->each;
      print "Valor @_[0]: R\$ @values[1]\n";
    }
    elsif ($response_bitcoin->is_error)   {
      print $response_bitcoin->message;
    } else {
      print 'Whatever...';
    }
  }
}

main();
