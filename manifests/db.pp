class bareos::db { 
   require bareos
$script_directory = lookup('bareos::db::script_dir')                     #'/usr/lib/bareos/scripts'
   $db_parameters = lookup('bareos::db::db_parameters')                     # " --user='root' --password=''"
         $db_type = lookup('bareos::db::db_type')
         $db_user = lookup('bareos::db::db_user')
         $db_pass = lookup('bareos::db::db_pass')                                                               #'mysql'
         $db_name = lookup('bareos::db::db_name')
exec { "create-db":
      unless => "/usr/bin/mysql -uroot $db_name",
      command => "/usr/bin/mysql -uroot -e \"create database $db_name;\"",
      require => Service['mysql'],
      }
 exec { "grant--db":
      unless => "/usr/bin/mysql -u$db_user -p$db_pass $db_name",
      command => "/usr/bin/mysql -uroot -e \"grant all on $db_name.* to '$db_user'@'localhost' identified by '$db_pass';\"",
      require => Service['mysql'],
     }
 

exec { 'make_tables':
         command => "${script_directory}/make_bareos_tables ${db_type} ${db_parameters}",
            
      }
exec { 'grant_privileges':
         command  => "${script_directory}/grant_bareos_privileges ${db_type} ${db_parameters}",
         refreshonly  => true,
   }
}
