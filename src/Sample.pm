package Sample;

use strict;
use warnings;

sub new {
    my ($class, %args) = @_;
    bless \%args, $class;
}


sub call {
    my ($self, $plefix) = @_;

    return "$plefix, " . $self->{name} . "\n";
}

1;
