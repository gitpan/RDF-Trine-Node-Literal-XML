use strict;
use warnings;

use inc::Module::Install;

license			'perl';

name                    'RDF-Trine-Node-Literal-XML';
author	                'Kjetil Kjernsmo <kjetilk@cpan.org>';
version_from        	'lib/RDF/Trine/Node/Literal/XML.pm';
abstract_from       	'lib/RDF/Trine/Node/Literal/XML.pm';
readme_from       	'lib/RDF/Trine/Node/Literal/XML.pm';

test_requires		'Test::More'				=> '0.88';
test_requires		'Test::Exception'			=> 0;

include                 'Test::Signature';


requires 		'RDF::Trine'				=> 0.111;
requires		'Scalar::Util'				=> 0;
requires		'XML::LibXML'				=> 0;
requires		'Error'					=> 0;

# We need libxml2 at least 2.6.

# If we're on Debian, install the -dev:
dpkg_requires 'libxml2-dev';


# Thanks to Chris 'BinGOs' Williams for this
my $version = 0;
if ( can_run('xml2-config') ) {
  $version = `xml2-config --version`;
  chomp $version;
  if ($version lt '2.6.23') {
    die "Your libxml2 is too old. You need at least 2.6.23 to comply with canonicalisation rules";
  }
} else {
  warn "Cannot determine your libxml2 version. You need at least 2.6.23 to comply with canonicalisation rules";
}



sign;

WriteAll;
