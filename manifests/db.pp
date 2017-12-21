class bareos::db {
   require bareos
$script_directory = '/usr/lib/bareos/scripts'
$db_parameters = " --user='root' --password=''"
$db_type = 'mysql'

exec { "create-db":
      unless => "/usr/bin/mysql -uroot bareos",
      command => "/usr/bin/mysql -uroot -e \"create database bareos;\"",
      require => Package['mysql-server'],
      }
 exec { "grant--db":
      unless => "/usr/bin/mysql -ubareos -pbareos bareos",
      command => "/usr/bin/mysql -uroot -e \"grant all on bareos.* to 'bareos'@'localhost' identified by 'bareos';\"",
      require => Package['mysql-server'],
     }
 

exec { 'make_tables':
         command => "${script_directory}/make_bareos_tables ${db_type} ${db_parameters}",
           refreshonly  => true, 
      }
exec { 'grant_privileges':
         command  => "${script_directory}/grant_bareos_privileges ${db_type} ${db_parameters}",
         refreshonly  => true,
   }
}
