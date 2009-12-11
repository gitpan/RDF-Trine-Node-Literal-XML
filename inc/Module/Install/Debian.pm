#line 1
package Module::Install::Debian;

use strict;
use Module::Install::Base;
use English;

use vars qw{$VERSION @ISA};

BEGIN {
    $VERSION = '0.02';
    @ISA     = qw{Module::Install::Base};
}

sub dpkg_requires {
    my $self = shift;

    if ( !$self->can_run('dpkg') ) {
        warn 'No dpkg installed.';
        return;
    }

    while (@_) {
        my $package = shift or last;
        my $version = shift || 0;
        push @{ $self->{values}{dpkg_requires} }, [ $package, $version ];

        # Check for package
        print "Checking dpkg $package status...\n";
        my $dpkg_status  = `dpkg -s $package`;
        my $installed = ( $dpkg_status =~ /^Status\:.*installed/m );
        my ($installed_version) = ( $dpkg_status =~ /^Version\: (.*)$/m );

        if ($installed) {
            print "$package $version ... $installed_version\n";

            # Check version
            return;
        }
        else {
            print "$package $version ... missing\n";
        }

        # Check for apt-get
        if ( !$self->can_run('apt-get') ) {
            warn "No apt-get installed. Needs to but cannot install $package";
            return;
        }

        # Check for root?

        # Install package
        `apt-get install $package`;

    }

    $self->{values}{dpkg_requires};
}

1;

#line 118
