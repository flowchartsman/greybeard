use strict;
use warnings;
use feature "switch";

my $file = shift;
$file =~ /^.*gb-(\d+)([^-]*).*\.bdf$/;
my ($fontsize, $weight) = ($1,$2);

if ($weight eq "") { $weight = "Medium" }
elsif ($weight eq "b") { $weight = "Bold" }
elsif ($weight eq "i") { $weight = "Italic" }
elsif ($weight eq "bi") { $weight = "Bold Italic" }
my $cap_height = int($fontsize/2 +1);
my $x_height = int($cap_height-2);
$fontsize = "$fontsize"."px";
open FILE, $file or die "failed to open $file\n";

my @lines;

while (my $line = <FILE>) {
  if ($line =~ /^FONT/) {
	$line =~ s/Greybeard/Greybeard-$fontsize/;
	if ($weight eq "Italic") {
		$line =~ s/Medium/$weight/;
	}
	elsif ($weight eq "Bold Italic") {
		$line =~ s/Bold/$weight/;
	}
	push @lines, $line;
  }
  elsif ($line =~ /^WEIGHT_NAME/) {
	push @lines, "WEIGHT_NAME \"$weight\"\n";
  }
  elsif ($line =~ /^FAMILY_NAME/) {
	push @lines, "FAMILY_NAME \"Greybeard $fontsize\"\n";
  }
  elsif ($line =~ /^STARTPROPERTIES (\d+)/) {
	push @lines, "STARTPROPERTIES ".($1+2)."\n";
  }
  elsif ($line =~ /^ENDPROPERTIES/) {
	push @lines, "CAP_HEIGHT $cap_height\n";
	push @lines, "X_HEIGHT $x_height\n";
	push @lines, $line;
  }
  else {
	push @lines, $line;
  }
}

close FILE;

open FILE, '>', "$file" or die "Can't write to $file\n";
print FILE @lines;
close FILE;
