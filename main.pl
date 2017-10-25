use strict;
use warnings;

use Mojo::UserAgent;
use Mojo::DOM;
use Term::Screen::Uni;
use Text::ASCIITable;

sub main {
  my @months = qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );
  my @days = qw(Sun Mon Tue Wed Thu Fri Sat Sun);

  clear_screen();
  page_header();
  choose_currency_type();
}

sub clear_screen {
  my $scr = new Term::Screen::Uni;
  $scr->clrscr()
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

sub fisical_quotation {
  clear_screen();
  my %fisical_currencies_urls = (
        'Dolar Americano' => 'http://dolarhoje.com/',
        'Dolar Australiano' => 'http://dolarhoje.com/dolar-australiano-hoje/',
        'Dolar Canadense' => 'http://dolarhoje.com/dolar-canadense-hoje/',
        'Euro' => 'http://dolarhoje.com/euro/',
        'Libra' => 'http://dolarhoje.com/libra-hoje/',
        'Ouro' => 'http://dolarhoje.com/ouro-hoje/',
        'Peso Argentino' => 'http://dolarhoje.com/peso-argentino/',
      );

    page_header();

    my @data;

    while ((my $key, my $value) = each (%fisical_currencies_urls)) {
      my $price = scraper($value);
      my %fisical_currencies = (
        'Name' => $key,
        'Price' => $price,
      );

      push @data, \%fisical_currencies;
    }

    my $datetime = localtime();
    print_table(@data);
    print "\n Date: $datetime\n\n";

    options_menu();

    return 0;
}

sub crypto_quotation {
  clear_screen();
  my %crypto_currencies_urls = (
    'Bitcoin' => 'http://dolarhoje.com/bitcoin-hoje/',
    'Bitcoin Cash' => 'http://dolarhoje.com/bitcoin-cash-hoje/',
    'Decred' => 'http://dolarhoje.com/decred/',
    'Dash' => 'http://dolarhoje.com/dash/',
    'Etherum' => 'http://dolarhoje.com/ethereum/',
    'Iota' => 'http://dolarhoje.com/iota/',
    'Lisk' => 'http://dolarhoje.com/lisk/',
    'Litecoin' => 'http://dolarhoje.com/litecoin/',
    'Moenro' => 'http://dolarhoje.com/monero/',
    'Nem' => 'http://dolarhoje.com/nem/',
    'Neo' => 'http://dolarhoje.com/neo/',
    'Omisego' => 'http://dolarhoje.com/omisego/',
    'Riple' =>  'http://dolarhoje.com/ripple-hoje/',
    'Zcash' => 'http://dolarhoje.com/zcash/',
  );

  page_header();

  my @data;

  while ((my $key, my $value) = each (%crypto_currencies_urls)) {
    my $price = scraper($value);
    my %crypto_currencies = (
      'Name' => $key,
      'Price' => $price,
    );

    push @data, \%crypto_currencies;
  }

  my $datetime = localtime();
  print_table(@data);
  print "\n Date: $datetime\n\n\n";

  options_menu();

  return 0;
}

sub goodbye_message {
  clear_screen();
  print "\t\t\tThanks for using my program! :)\n\n";
  exit();
}

sub scraper {
  my $ua  = Mojo::UserAgent->new;
  my $response = $ua->get($_[0])->result;
  if    ($response->is_success)  {
    my $dom = Mojo::DOM->new($response->body);
    my @values = $dom->find('input')->map(attr => 'value')->compact->each;
    return $values[1];
  }
  elsif ($response->is_error)   {
    print $response->message;
  } else {
    print 'Somenthing wrong happened...';
  }
  return 0;
}

sub print_table {
  my $t = Text::ASCIITable->new({ headingText => 'Crypto Currencies' });
  $t->setCols('Name','Price');
  foreach my $line(@_) {
    $t->addRow($line->{"Name"}, "R\$ " . $line->{"Price"});
  }

  print $t;
}

sub page_header {
  print "*************************************************************************\n";
  print "\t\tTrabalho de Linguagens de Programacao - Parte II\n";
  print "\t\t\t\tUFRJ - 2017.2\n";
  print "\t\t\t\tLucas Vieira\n";
  print "*************************************************************************\n\n\n";
}

sub fisical_currencies_menu {

  currencies_header('Fisical');

  my $choice = <STDIN>;

  if ($choice == 1) {
    fisical_quotation();
  } elsif ($choice == 2) {
    main();
  } else {
    goodbye_message();
  }

  return 0;
}

sub crypto_currencies_menu {

  currencies_header('Crypto');

  my $choice = <STDIN>;

  if ($choice == 1) {
    crypto_quotation();
  } elsif ($choice == 2) {
    main();
  } else {
    goodbye_message();
  }

  return 0;
}

sub options_menu {
  print "\t1 - Store data\n";
  print "\t2 - Home\n\n";
  print "\tPress anything else to exit.\n\n";
  print "Option: ";

  my $choice = <STDIN>;

  if ($choice == 1) {
    store_data();
  } elsif ($choice == 2) {
    main();
  } else {
    goodbye_message();
  }

  return 0;
}

sub store_data {
  clear_screen();
  print "Data stored!\n";
  print "Press ENTER to continue...";

  my $user_input = <STDIN>;

  main();

  return 0;
}

sub currencies_header {
  clear_screen();
  page_header();
  print "$_[0] Currencies\n\n";

  print "\t1 - View actual values\n";
  print "\t2 - Back\n\n";
  print "\tPress anything else to exit.\n\n";
  print "Option: ";
}

main();
