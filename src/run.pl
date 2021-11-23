use lib '.';
use Sample;

my $sample = Sample->new(name => 'Yuto');

print $sample->call("Hello");
