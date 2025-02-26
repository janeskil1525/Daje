use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('Daje');

$t->post_ok('/workflow' =>
    {
        'X-Token-Check' => 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb21wYW5pZXNfcGtleSI6MjQsImNvbXBhbnkiOiJEYWplIEFCIiwiaXNfYWRtaW4iOjAsInBhc3N3b3JkIjoiMGdZVzZqTXU3dFwvcWVORHVRS2hON2xOSmJtaTRHTkxpVE94ZFZWUnFtazI0TllBamlCVElnRThiNHBTWFdXNmV2R09QRlFXVTBLbXJ0cnZqaFk4ZHVBIiwic3VwcG9ydCI6MSwidXNlcmlkIjoiamFuQGRhamUud29yayIsInVzZXJuYW1lIjoiSmFuIEVza2lsc3NvbiIsInVzZXJzX3BrZXkiOjI0fQ.oUhzZDxjDVNLUhWt81BBtKPFzpFiTBYxTGjW5Pk92V0'
    } => json => {
    'email'           => 'janeskil1525@gmail.com',
    'company_orgnr'   => 'dfgdsgfs',
    'password'        => '1234',
    'user_name'       => 'Jan Eskilsson',
    'company_name'    => 'Test company',
    'company_address' => 'Winkegasse 24b, 5503 Schafisheim',
    'workflow'        => {
        workflow_pkey => 0,
        'workflow'    => 'new_client',
        'activity'    => 'new_client'
    }
})->status_is(200)->content_like(qr/Success/i);

done_testing();

