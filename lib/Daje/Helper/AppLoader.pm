package Daje::Helper::AppLoader;
use Mojo::Base -base, -signatures;
use v5.40;

use Mojo::JSON qw (from_json);

sub process($self, $app) {
    try {
        my $loadables = $app->config("load_ables");

        if(exists $loadables->{namespaces}->{plugins}) {
            my $length = scalar @{$loadables->{namespaces}->{plugins}};
            for(my $i = 0; $i < $length; $i++) {
                push @{$app->plugins->namespace}, @{$loadables->{namespaces}->{plugins}}[$i]->{name}
            }
        }

        if(exists $loadables->{namespaces}->{routes}) {
            my $length = scalar @{$loadables->{namespaces}->{routes}};
            for(my $i = 0; $i < $length; $i++) {
                push @{$app->routes->namespace}, @{$loadables->{namespaces}->{routes}}[$i]->{name}
            }
        }

        if(exists $loadables->{plugin}) {
            my $length = scalar @{$loadables->{plugin}};
            for(my $i = 0; $i < $length; $i++) {
                $app->plugin(@{$loadables->{plugin}}[$i]->{name});
            }
        }

        if(exists $loadables->{helper}) {
            my $length = scalar @{$loadables->{helper}};
            for(my $i = 0; $i < $length; $i++) {

                $app->helper(@{$loadables->{helper}}[$i]->{name});
            }
        }

        $self->helper(pg => sub {state $pg = Mojo::Pg->new->dsn(shift->config('pg'))});
        my $test = 1;
    } catch ($e) {

    }
}
1;