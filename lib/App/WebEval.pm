package App::WebEval;

use Web::Simple;
use Template;
use Cwd;

use IO::Socket::IP;

use Plack::App::File;
use JSON;

our $VERSION = '0.01';

sub dispatch_request {
    my ($self, $env) = @_;
    
    sub (GET + /) {
        redispatch_to '/static/index.html';
    },
    sub (GET + /static/...) {
        #my $f = getcwd . '/root/static/' . $_[1]; 
        #-e $f ? Plack::App::File->new(file => $f)
        #      : [404, ['Content-type', 'text/plain'], [$_[1] . ' not found']];
        Plack::App::File->new(root => getcwd . '/root/static/');
    },
    sub (POST + /eval + %code=) {
        my $code = $_[1]; 

        my $request = encode_json({
            lang => 'Perl',
            code => $code,
        });

        my $sock = IO::Socket::IP->new( 
            PeerHost => "localhost", 
            PeerPort => 14400 
        ) or die "Cannot - $@";

        $sock->print($request);

        my $response = do { local $/; <$sock> };
        [200, ['Content-type', 'text/plain'], [$response]];
    }
}

__PACKAGE__->run_if_script;

=head1 NAME

App::WebEval - A web-based eval server

=head1 VERSION

Version 0.01

=cut

=head1 SYNOPSIS

Simply plackup the webeval.psgi script to have a website with a Perl evalbot on
it. Or use the modules herein to run your own, using this CGI::Application, er,
application as a clue.

=cut

=head1 AUTHOR

Altreus, C<< <altreus at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-app-webeval at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=App-WebEval>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc App::WebEval


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=App-WebEval>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/App-WebEval>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/App-WebEval>

=item * Search CPAN

L<http://search.cpan.org/dist/App-WebEval/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Altreus.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut
