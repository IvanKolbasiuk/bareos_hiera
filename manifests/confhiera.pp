class bareos::confhiera {
#require bareos

$defaults = {
#require =>  Class['bareos'],
#notify => Service['bareos-sd', 'bareos-fd', 'bareos-dir'],
  owner => 'bareos',
  group => 'bareos',
  mode => '0750',
 # require => Package['bareos'], 
}
#require =>  Class['bareos'],
#notify => Service['bareos-sd', 'bareos-fd', 'bareos-dir'],
$files = lookup('bareos::confhiera::files',Hash)
create_resources ( file, $files, $defaults)
}
