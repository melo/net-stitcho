package Net::Stitcho;

use warnings;
use strict;
use base qw( Class::Accessor::Fast );
use Carp::Clan;
use URI::Escape qw( uri_escape_utf8 );
use Digest::MD5 qw( md5_hex );

our $VERSION = '0.02';

__PACKAGE__->mk_ro_accessors(qw( key id ));

sub send_uri {
  my ($self, $args) = @_;
  
  # Parse arguments
  my ($email, $title, $mesg, $url)
      = _req_params($args, qw( email title message url ));
  my $icon = $args->{icon};
  
  # Construct list of parameters to sign
  my @params;
  push @params, 'p='.$self->id;
  push @params, 'i='.$icon if defined $icon;
  push @params, 'md5='.md5_hex($email);
  push @params, 't='.uri_escape_utf8($title);
  push @params, 'm='.uri_escape_utf8($mesg);
  push @params, 'u='.uri_escape_utf8($url);
  
  return $self->_signed_api_call('send', @params);
}

sub send {
  my $self = shift;
  
  my $uri = $self->send_uri(@_);
  
  eval { require LWP::UserAgent };
  croak('FATAL: LWP::UserAgent is required to use the send() method')
    if $@;
  
  my $ua = LWP::UserAgent->new;
  my $res = $ua->get($uri);

  my $code = $res->code;
  return undef if $code == 200;
  return $code;
}


sub signup_uri {
  my ($self, $args) = @_;
  
  # Parse arguments
  my ($email, $mesg)
      = _req_params($args, qw( email message ));
  
  # Construct list of parameters to sign
  my @params;
  push @params, 'p='.$self->id;
  push @params, 'e='.uri_escape_utf8($email);
  push @params, 'm='.uri_escape_utf8($mesg);
  
  return $self->_signed_api_call('signup', @params);
}


#######
# Utils

sub _signed_api_call {
  my ($self, $api, @params) = @_;
  
  my $call = join('&', @params);
  
  # sign the call
  my $sig = md5_hex($call.$self->key);
  
  # construct the final URL
  return qq{http://api.stitcho.com/api/partner/$api?$call&s=$sig};
}

sub _req_params {
  my $args = shift;
  croak('FATAL: hashref is required as first argument, ')
    unless ref($args) eq 'HASH';
  
  my @r;
  foreach my $k (@_) {
    croak("FATAL: required parameter '$k' is missing, ")
      unless exists $args->{$k};
    
    push @r, $args->{$k};
  }
  
  return @r;
}


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
    
    my $error = $api->send({
      # same arguments as send_uri()
      # this version uses LWP::UserAgent to actually call the API
    });



=head1 DESCRITION

The module provides access to the Stitcho.com notification service using the
provided HTTP-based API.

You need to get an partner account at the site. After you have your API
secret key, you can start to use this module.

You can use this module in two ways:

=over 4

=item * to generate the proper URIs to use with the API;

=item * to call the API;

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



=head2 send_uri

Constructs the URI to use to send a notification to a user.

Accepts a hashref of parameters. Valid keys are:


=over 4

=item email

Email address of recipient.

=item title

Title of the notification.

=item message

Message text.

=item url

If the message is clicked, the users browser will open with this URL.

=item icon (optional)

Numeric ID of the icon to use.

=back

Returns the complete URI to use to call the Send API. Use your prefered
HTTP client to do the actual call.



=head2 send

Sends a notification to a user.

Accepts the same parameters as the send_uri() method.

After creating a proper URL, uses LWP::UserAgent to call the API.

If successful, returns no error (undef).

If not, returns the HTTP code of the operation. As of October 2008, the
documented HTTP codes are:


=over 4


=item 202

The call was formatted correctly, but the user was not connected, so the 
notiﬁcation was not sent.


=item 400

The request was incorrectly formatted.

If you get this error code, report it as a bug to the author of this module.


=item 401

The signature was invalid. Check the id and key parameters to your
call to new().


=item 500

An unanticipated error occurred, and the problem most likely lies 
with Stitcho, not your software. Retry in a minute or so.

=back



=head2 signup_uri

Constructs the URI to use to send the signup email message
to a email address.

Accepts a hashref of parameters. Valid keys are:


=over 4

=item email

Email address of recipient.

=item message

Email message text.

=back

Returns the complete URI to use to call the Signup API. Use your prefered
HTTP client to do the actual call.




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

