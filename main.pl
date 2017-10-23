use strict;
use warnings;
use Switch;

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
sub fisical_currencies_menu  {
  clear_screen();
  print "\t\t\tMenu - Fisical Currencies\n\n";
  exit();
}

sub crypto_currencies_menu {
  clear_screen();
  print "\t\t\tMenu - Crypto Currencies\n\n";
  exit();
}

sub goodbye_message {
  clear_screen();
  print "\t\t\tThanks for using our program!\n\n";
  exit();
}

sub choose_currency_type {
  print "Choose the currency type:\n\n";

  print "\t1 - Fisical Currencies\n";
  print "\t2 - Crypto Currencies\n\n";
  print "\tPress anything else to exit.\n\n";
  print "Option: ";

  my $choice = <STDIN>;

  if ($choice == 1) {
    fisical_currencies_menu();
  } elsif ($choice == 2) {
    crypto_currencies_menu();
  } else {
    goodbye_message();
  }
}

main();
