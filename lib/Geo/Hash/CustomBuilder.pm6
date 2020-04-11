use v6;
use LibraryMake;
use Distribution::Builder::MakeFromJSON;

class Geo::Hash::CustomBuilder:ver<0.0.2> is Distribution::Builder::MakeFromJSON {
    method build(IO() $work-dir = $*CWD) {
        my $workdir = ~$work-dir;
        my $srcdir = "$workdir/src";
        my %vars = get-vars($workdir);
        %vars<geohash> = $*VM.platform-library-name('geohash'.IO);
	mkdir "$workdir/resources" unless "$workdir/resources".IO.e;
	mkdir "$workdir/resources/libraries" unless "$workdir/resources/libraries".IO.e;
	process-makefile($srcdir, %vars);
	my $goback = $*CWD;
	chdir($srcdir);
	shell(%vars<MAKE>);
	chdir($goback);
    }
}
