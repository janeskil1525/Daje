package Daje::Controller::Example;
use Mojo::Base 'Mojolicious::Controller', -signatures;

# This action will render a template
sub welcome ($self) {

  # Render template "example/welcome.html.ep" with message
  $self->render(msg => 'Welcome to the Mojolicious real-time web framework!');
}

1;

#################### pod generated by Pod::Autopod - keep this line to make pod updates possible ####################

=head1 NAME

Daje::Controller::Example


=head1 DESCRIPTION

This action will render a template


=head1 REQUIRES

L<Mojo::Base> 


=head1 METHODS

=head2 welcome

 welcome();

This action will render a template



=cut

