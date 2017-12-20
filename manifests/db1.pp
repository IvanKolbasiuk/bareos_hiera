 class {'bareos::db1': 
   # root_password    => '1111',
    override_options => {
      'mysqld' => {
        'max_connections' => '1024',
        },
      },
    databases        => {
      'bareos' => {
        # lint:ignore:ensure_first_param
        ensure  => present,
        # lint:endignore
        charset => 'utf8',
      },
    },
    grants           => {
      'bareos@localhost/bareos.*' => {
        ensure     => present,
        options    => [ 'GRANT' ],
        privileges => [ 'ALL' ],
        table      => 'bareos.*',
        user       => 'bareos@localhost',
      },
    },
    users            => {
      'bareos@localhost' => {
        ensure                   => 'present',
        max_connections_per_hour => '0',
        max_queries_per_hour     => '0',
        max_updates_per_hour     => '0',
        max_user_connections     => '0',
        password_hash            => $bareos::db_password_hash,
      },
    },
}
