class bareos::repo {

  file { '/etc/apt/sources.list.d/bareos.list':
           content => "deb http://download.bareos.org/bareos/release/latest/xUbuntu_14.04 /\n"
          }
          ~>
          exec { 'bareos-key':
            command     => "/usr/bin/wget -q http://download.bareos.org/bareos/release/latest/xUbuntu_14.04/Release.key -O- | /usr/bin/apt-key add -",
            refreshonly => true
          }
         
   }
        










