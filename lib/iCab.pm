# $Id$
package HTTP::Cookies::iCab;
use strict;

=head1 NAME

HTTP::Cookies::iCab - Cookie storage and management for iCab

=head1 SYNOPSIS

use HTTP::Cookies::iCab;

$cookie_jar = HTTP::Cookies::iCab->new;

# otherwise same as HTTP::Cookies

=head1 DESCRIPTION

This package overrides the load() and save() methods of HTTP::Cookies
so it can work with iCab cookie files.

See L<HTTP::Cookies>.

=head1 SOURCE AVAILABILITY

This source is part of a SourceForge project which always has the
latest sources in CVS, as well as all of the previous releases.

	https://sourceforge.net/projects/brian-d-foy/

If, for some reason, I disappear from the world, one of the other
members of the project can shepherd this module appropriately.

=head1 AUTHOR

brian d foy, E<lt>bdfoy@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2003, brian d foy, All rights reserved

This library is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut

#/Users/brian/Library/Preferences/iCab Preferences/iCab Cookies
# Time::Local::timelocal(0,0,0,1,0,70)

use base qw( HTTP::Cookies );
use vars qw( $VERSION );

use constant TRUE   => 'TRUE';
use constant FALSE  => 'FALSE';
use constant OFFSET => 2_082_823_233;

$VERSION = sprintf "%2d.%02d", q$Revision$ =~ m/ (\d+) \. (\d+) /xg;

sub load
	{
    my( $self, $file ) = @_;
 
    $file ||= $self->{'file'} || return;
 
    open my $fh, $file or return;

	until( eof $fh )
		{
		my $set_date = read_date( $fh );

		$tag         = read_str( $fh, 4 );
		warn( "tag is [$tag] not 'Cook'" ) unless $tag eq 'Cook';

		my $name    = read_var( $fh );
		my $path    = read_var( $fh );
		my $domain  = read_var( $fh );
		my $value   = read_var( $fh );
		
		
		}	
	$self->set_cookie(undef, @bits[2,3,1,0], undef,
		0, 0, $expires - time, 0);
    	
    close $fh;
    
    1;
	}

sub save
	{
    my( $self, $file ) = @_;

    $file ||= $self->{'file'} || return;
 	
    $self->scan(
    	sub {
			my( $version, $key, $val, $path, $domain, $port,
				$path_spec, $secure, $expires, $discard, $rest ) = @_;

			return if $discard && not $self->{ignore_discard};

			return if time > $expires;

			$expires = do {
				unless( $expires ) { 0 }
				else
					{
					my @times = localtime( $expires );
					$times[5] += 1900;
					$times[4] += 1;
					
					sprintf "%4d-%02d-%02dT%02d:%02d:%02dZ",
						@times[5,4,3,2,1,0];
					}
				};		
 
			$secure = $secure ? TRUE : FALSE;

			my $bool = $domain =~ /^\./ ? TRUE : FALSE;

	    		}
		} );
		
	open my $fh, "> $file" or die "Could not write file [$file]! $!\n";
    close $fh;
	}
	
sub read_int
	{
	my $fh;
	
	my $result = read_str( $fh, 4 );
	
	}

sub read_date
	{
	my $fh;
	
	my $string = read_str( $fh, $length );
	warn( "tag is [$tag] not 'Date'" ) unless $tag eq 'Date';
	
	my $date = read_int( $fh );
	warn( sprintf "read date %X | %d | %s", $set_date, $set_date,
		scalar localtime $set_date );
	
	return $string;
	}
	
sub read_var
	{
	my $fh;
	
	my $length = read_int( $fh );
	my $string = read_str( $fh, $length );
	
	return $string;
	}
		
sub read_str
	{
	my $fh;
	my $length;
	
	my $result = read( $fh, $string, $length );
	
	return $string;
	}

1;
