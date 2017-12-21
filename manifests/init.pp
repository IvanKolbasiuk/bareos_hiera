class bareos  {

 require bareos::repo

 exec { 'apt-update':                   
    command => '/usr/bin/apt-get update'  
  }
  # install mysql-server package
 package { 'mysql-server':
    require => Exec['apt-update'],       
    ensure => installed,
 }

 #  ensure mysql service is running
 service { 'mysql':
    ensure => running,
    require =>Package['mysql-server'],
   }
include bareos::db
 package { 'bareos':
    require => Exec['apt-update'],       
    ensure => installed,
  }
 include bareos::conf 
 package { 'bareos-database-mysql':
    require => Exec['apt-update'],
    ensure => installed,
   }
 service {'bareos-dir':
    ensure => running,
    }
 service {'bareos-sd':
    ensure => running,
    }
 service {'bareos-fd':
    ensure => running,
    }    
}































