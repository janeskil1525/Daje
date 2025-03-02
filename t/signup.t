use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('Daje');

$t->post_ok('/signup' => json => {
    'user' => {
        'userid'        => 'janeskil1525@gmail.com',
        'password'      => '1234',
        'username'      => 'Jan Eskilsson',
        'active'        => 1,
        'workflow_fkey' => 23,
    },
    'company' => {
        'company_orgnr'   => 'dfgdsgfs',
        'company_name'    => 'Test company',
        'company_address' => 'Winkegasse 24b, 5503 Schafisheim',
        'company_type_fley' => 1
    }
})->status_is(200)->content_like(qr/Success/i);

done_testing();

