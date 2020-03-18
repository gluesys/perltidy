# Created with: ./make_t.pl

# Contents:
#1 rt132059.def
#2 rt132059.rt132059
#3 signature.def

# To locate test #13 you can search for its name or the string '#13'

use strict;
use Test;
use Carp;
use Perl::Tidy;
my $rparams;
my $rsources;
my $rtests;

BEGIN {

    ###########################################
    # BEGIN SECTION 1: Parameter combinations #
    ###########################################
    $rparams = {
        'def'      => "",
        'rt132059' => "-dac",
    };

    ############################
    # BEGIN SECTION 2: Sources #
    ############################
    $rsources = {

        'rt132059' => <<'----------',
# Test deleting comments and pod
$1=2;
sub f { # a side comment
 # a hanging side comment

# a block comment
}

=pod
bonjour!
=cut

$i++;
----------

        'signature' => <<'----------',
# git22: Preserve function signature on a single line
# This behavior is controlled by 'sub weld_signature_parens'

sub foo($x, $y="abcd") {
  $x.$y;
}

# do not break after closing do brace
sub foo($x, $y=do{{}}, $z=42, $w=do{"abcd"}) {
  $x.$y.$z;
}

# This signature should get put back on one line
sub t022 (
    $p = do { $z += 10; 222 }, $a = do { $z++; 333 }
) { "$p/$a" }

# anonymous sub with signature
my $subref = sub ( $cat, $id = do { state $auto_id = 0; $auto_id++ } ) {
    ...;
};
----------
    };

    ####################################
    # BEGIN SECTION 3: Expected output #
    ####################################
    $rtests = {

        'rt132059.def' => {
            source => "rt132059",
            params => "def",
            expect => <<'#1...........',
# Test deleting comments and pod
$1 = 2;

sub f {    # a side comment
           # a hanging side comment

    # a block comment
}

=pod
bonjour!
=cut

$i++;
#1...........
        },

        'rt132059.rt132059' => {
            source => "rt132059",
            params => "rt132059",
            expect => <<'#2...........',
$1 = 2;

sub f {
    
}


$i++;
#2...........
        },

        'signature.def' => {
            source => "signature",
            params => "def",
            expect => <<'#3...........',
# git22: Preserve function signature on a single line
# This behavior is controlled by 'sub weld_signature_parens'

sub foo ( $x, $y = "abcd" ) {
    $x . $y;
}

# do not break after closing do brace
sub foo ( $x, $y = do { {} }, $z = 42, $w = do { "abcd" } ) {
    $x . $y . $z;
}

# This signature should get put back on one line
sub t022 ( $p = do { $z += 10; 222 }, $a = do { $z++; 333 } ) {
    "$p/$a";
}

# anonymous sub with signature
my $subref = sub ( $cat, $id = do { state $auto_id = 0; $auto_id++ } ) {
    ...;
};
#3...........
        },
    };

    my $ntests = 0 + keys %{$rtests};
    plan tests => $ntests;
}

###############
# EXECUTE TESTS
###############

foreach my $key ( sort keys %{$rtests} ) {
    my $output;
    my $sname  = $rtests->{$key}->{source};
    my $expect = $rtests->{$key}->{expect};
    my $pname  = $rtests->{$key}->{params};
    my $source = $rsources->{$sname};
    my $params = defined($pname) ? $rparams->{$pname} : "";
    my $stderr_string;
    my $errorfile_string;
    my $err = Perl::Tidy::perltidy(
        source      => \$source,
        destination => \$output,
        perltidyrc  => \$params,
        argv        => '',             # for safety; hide any ARGV from perltidy
        stderr      => \$stderr_string,
        errorfile => \$errorfile_string,    # not used when -se flag is set
    );
    if ( $err || $stderr_string || $errorfile_string ) {
        if ($err) {
            print STDERR
"This error received calling Perl::Tidy with '$sname' + '$pname'\n";
            ok( !$err );
        }
        if ($stderr_string) {
            print STDERR "---------------------\n";
            print STDERR "<<STDERR>>\n$stderr_string\n";
            print STDERR "---------------------\n";
            print STDERR
"This error received calling Perl::Tidy with '$sname' + '$pname'\n";
            ok( !$stderr_string );
        }
        if ($errorfile_string) {
            print STDERR "---------------------\n";
            print STDERR "<<.ERR file>>\n$errorfile_string\n";
            print STDERR "---------------------\n";
            print STDERR
"This error received calling Perl::Tidy with '$sname' + '$pname'\n";
            ok( !$errorfile_string );
        }
    }
    else {
        ok( $output, $expect );
    }
}