use strict;
use warnings;

my $text = 'ほげ';
print length($text);

print "\n";

use utf8;
use Encode;
my $text2 = 'ほげ';
print length $text2;
print encode_utf8 "$text2\n"
