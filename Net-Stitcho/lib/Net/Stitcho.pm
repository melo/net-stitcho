package Net::Stitcho;

use warnings;
use strict;
use base qw( Class::Accessor::Fast );

our $VERSION = '0.01';

__PACKAGE__->mk_ro_accessors(qw( key id api_end_point ));


42; # End of Net::Stitcho

__END__

=head1 NAME

Net::Stitcho - Client module for the Stitcho.com API



=head1 VERSION

Version 0.01



=head1 SYNOPSIS

    use Net::Stitcho;
    
    my $api = Net::Stitcho->new({
      id  => 1,          # your partner id
      key => '3246327a', # the secrect signing key
    });
    
    my $uri = $api->send_uri({
      email   => 'melo@cpan.org',       # Recipient address
      message => 'Yuppi!',              # Message to send
      url     => 'http://stitcho.com/', # Jump to this URL on click
      icon    => 1,                     # ID of the icon to use
    });


=head1 DESCRITION

The module provides access to the Stitcho.com notification service using the
provided HTTP-based API.

You need to get an partner account at the site. After you have your API
secret key, you can start to use this module.

You can use this module in two ways:

=over 4

=item to generate the proper URIs to use with the API;

=item to call the API;

=back

The first option is best if you have a way to do the HTTP GET request
yourself. For example, if you are using AnyEvent or POE, you can use
their Async HTTP client to call the API using the URI calculated by
this module.



=head1 METHODS

=head2 new

Creates a new API object. Accepts a hashref of parameters. Valid keys are:

=over 4

=item id

Partner ID provided by Stitcho.com.

=item key

Secret signing key provided by Stitcho.com.

=back

Returns a API object.



=head1 EXPORT

This module does not export any symbols.


=head1 AUTHOR

Pedro Melo, C<< <melo at cpan.org> >>



=head1 BUGS

Please report any bugs or feature requests to C<bug-net-stitcho at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Net-Stitcho>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Net::Stitcho


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Net-Stitcho>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Net-Stitcho>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Net-Stitcho>

=item * Search CPAN

L<http://search.cpan.org/dist/Net-Stitcho>

=back



=head1 COPYRIGHT & LICENSE

Copyright 2008 Pedro Melo.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

