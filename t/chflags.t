#
# $Id: chflags.t,v 1.20 2002/01/26 04:17:06 dankogai Exp $
#
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
use strict;
my $Debug = 0;
BEGIN { plan tests => 5 };

use BSD::stat;
use File::Copy;

my $dummy = $0; $dummy =~ s,([^/]+)$,dummy,o;
copy($0, $dummy) or die "copy $0 -> $dummy failed!";
chflags(UF_IMMUTABLE, $dummy) ? ok(1) : ok(0);

lstat($dummy)->flags == UF_IMMUTABLE ? ok(1) : ok(0);

unlink($dummy) ? ok(0) : ok(1);
$Debug and warn $!;
chflags(0, $dummy) ? ok(1) : ok(0);
unlink($dummy) ? ok(1) : ok(0);

