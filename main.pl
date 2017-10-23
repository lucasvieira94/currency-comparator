use strict;
use warnings;
use Switch;

sub main {
  print "*************************************************************************\n";
  print "\t\tTrabalho de Linguagens de Programacao - Parte II\n";
  print "\t\t\t\tUFRJ - 2017.2\n";
  print "\t\t\t\tLucas Vieira\n";
  print "*************************************************************************\n\n\n";

  choose_currency_type();
}

sub fisical_currencies_menu {

}

sub crypto_currencies_menu {

}

sub goodbye_message {

}

sub choose_currency_type {
  print "Choose the currency type:\n\n";

  print "\t1 - Fisical Currencies\n";
  print "\t2 - Crypto Currencies\n";
  print "\t3 - Exit\n";

  my $choice = <STDIN>;

  switch($choice) {
    case 1 {
      fisical_currencies_menu();
    }
    case 2 {
      crypto_currencies_menu();
    }
    else {
      goodbye_message();
    }
  }
}

main();
