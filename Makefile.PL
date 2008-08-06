# $Id$
use ExtUtils::MakeMaker;

require 5.006;

eval "use Test::Manifest 1.14";
	
WriteMakefile
	(
	'NAME'           => 'HTTP::Cookies::iCab',
	'ABSTRACT'       => 'Cookie storage and management for iCab',
	'VERSION_FROM'   => 'lib/iCab.pm',
	'LICENSE'        => 'perl',
	'AUTHOR'         => 'brian d foy <bdfoy@cpan.org>',

	'PREREQ_PM'      => {
		'HTTP::Cookies'         => '1.25',
		'Text::Diff'            => '0',
		},
		
	'PM'             => {
		'lib/iCab.pm' => '$(INST_LIBDIR)/iCab.pm',
		},
	'MAN3PODS'		 => {
		'lib/iCab.pm' => '$(INST_MAN3DIR)/HTTP::Cookies::iCab.3',
		},
	
	clean => { FILES => 'HTTP-Cookies-iCab-*' },
	);

