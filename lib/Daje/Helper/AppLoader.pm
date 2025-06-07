package Daje::Helper::AppLoader;
use Mojo::Base -base, -signatures;
use v5.40;

use Mojo::JSON qw (from_json);
use Mojo::Loader qw(load_class);

sub process($self, $app) {
    try {
        my $pg = $app->pg;
        my $loadables = $app->config("load_ables");

        if(exists $loadables->{namespaces}->{plugins}) {
            my $length = scalar @{$loadables->{namespaces}->{plugins}};
            for(my $i = 0; $i < $length; $i++) {
                push @{$app->plugins->namespaces}, @{$loadables->{namespaces}->{plugins}}[$i]->{name}
            }
        }

        if(exists $loadables->{namespaces}->{routes}) {
            my $length = scalar @{$loadables->{namespaces}->{routes}};
            for(my $i = 0; $i < $length; $i++) {
                push @{$app->routes->namespaces}, @{$loadables->{namespaces}->{routes}}[$i]->{name}
            }
        }

        if(exists $loadables->{plugin}) {
            my $length = scalar @{$loadables->{plugin}};
            for(my $i = 0; $i < $length; $i++) {
                if (exists @{$loadables->{plugin}}[$i]->{options}) {
                    my %plugin = $self->_plugin_options(
                        $app,
                        @{$loadables->{plugin}}[$i]->{name},
                        @{$loadables->{plugin}}[$i]->{options}
                    );
                    $app->plugin(
                        %plugin
                    );
                } else {
                    $app->plugin(@{$loadables->{plugin}}[$i]->{name});
                }
            }
        }

        if(exists $loadables->{helper}) {
            my $length = scalar @{$loadables->{helper}};
            for(my $i = 0; $i < $length; $i++) {
                my $class = @{$loadables->{helper}}[$i]->{class};
                if (my $e = load_class $class) {
                    $app->log->fatal($e);
                }
                my $name = @{$loadables->{helper}}[$i]->{name};
                $app->helper($name => sub{ state $var = $class->new()});
                # self->helper(jwt => sub {state $jwt = Daje::Tools::JWT->new()});
            }
        }

        my $test = 1;
    } catch ($e) {
        my $error = $;
    }
}

sub _plugin_options($self, $app, $name, $options) {

    my %plugin = ();
    my %result = ();

    my $length = scalar @{$options};
    for (my $i = 0; $i < $length; $i++) {
        my $plug = @{$options}[$i]->{name};
        $plugin{$plug} = @{$options}[$i]->{option};
    }

    $result{$name} = %plugin;

    return %result;
}
1;