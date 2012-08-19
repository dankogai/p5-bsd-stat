#
# $Id: utimes.t,v 1.30 2012/08/19 15:36:31 dankogai Exp $
#

use strict;
use warnings;
use BSD::stat;
use Test::More tests => 5;
use File::Spec;

my $target = File::Spec->catfile('t', "test$$");
my $symlink = File::Spec->catfile('t', "link$$");
open my $wfh, ">$target" or die "($target):$!";
my $when = 1234567898.765432;
ok utimes($when, $when, $target), "utimes($when, $when, $target)";
my $st = stat($target);
$when = 1234567890.987654;
ok utimes($when, $when, $wfh), "utimes($when, $when, $wfh)";
$st = stat($wfh);
close $wfh;

symlink $target, $symlink or die "symlink $target, $symlink : $!";
ok lutimes(0, 0, $symlink), "lutimes($when, $when, $symlink)";
is lstat($symlink)->mtime, 0, "lutimes() does touch $symlink";
is lstat($target)->mtime, 1234567890, "lutimes() leaves $target";

unlink($target, $symlink) == 2 or die "unlink($target, $symlink):$!";
