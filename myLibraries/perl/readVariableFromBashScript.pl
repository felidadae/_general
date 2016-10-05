package readVariableFromBashSource;

use strict;
use warnings;

use Exporter 'import';
our @EXPORT  = qw(readVariableFromBashSource);
our $VERSION = '1.00';


##**************
## ^^^ get values of a variable from a bash script;
##	take first assignment occureances for a variable;
sub readVariableFromBashSource {
	#ARG
	my $iarg = 0; 
	my $pathToConfig = $_[$iarg++];
	my $argid 		 = $_[$iarg++];

	#RETURN
	my $returnValue="";

	open(my $fileRef, '<', $pathToConfig) or die "Could not open file!";
	foreach my $l (<$fileRef>) {
		if ($l =~ /^\s*$argid=([A-Za-z0-9_]*)/) { 
			$returnValue="$1";
			last; 
		}
	}
	$returnValue;
}
##**************

sub readBashVariables {
	##Arguments: or none or all
	my $iarg = 0;
	my $filePath = $_[$iarg++];
	my $variableNames = $_[$iarg++]; #array ref

	my @result;

	open(my $fileRef, '<', $filePath) or die "Path with given path does not exist.";
	foreach my $l (<$fileRef>) {
		my $iv=0;
		foreach my $v (@$variableNames) {
			if ($l =~ /$v="?([^"\n#]+?)"?\s*($|#)/) { 
				$result[$iv] = $1;
				last;
			}
			$iv++
		}
	}

	\@result;
}

my $result = parseBash("_archivizator/test/tools_config.sh", ["remoteOld", "remoteNew"]);
foreach (@$result) {
	print $_ . "\n";
}
