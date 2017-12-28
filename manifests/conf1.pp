class bareos::conf1 {

  $db_type = lookup('bareos::db::db_type')
  $db_user = lookup('bareos::db::db_user')
  $db_pass = lookup('bareos::db::db_pass')                                                               
  $db_name = lookup('bareos::db::db_name')
  $f_owner = lookup('bareos::conf1::f_owner')
  $f_group = lookup('bareos::conf1::f_group')
  $f_mode = lookup('bareos::conf1::f_mode')
  $job_name = lookup('bareos::conf1::job_name')
  $job_def = lookup('bareos::conf1::job_def')
  $b_level = lookup('bareos::conf1::b_level')	 
  $fileset = lookup('bareos::conf1::fileset')
  $schedule = lookup('bareos::conf1::schedule') 
  $source_path = lookup('bareos::conf1::source_path.0')
  $backup_path = lookup('bareos::conf1::backup_path') 
 $content = "catalog {
    Name = MyCatalog
    dbuser = $db_user
    dbname = $db_name
    dbdriver = $db_type
    dbpassword = $db_pass
    }"

 $content_myapp = "Job {
    Name = $job_name
    JobDefs = $job_def
    Client = bareos-fd
    Level = $b_level
    FileSet = $fileset
    Schedule = $schedule
    }" 
  $content_fileset = "FileSet {
  Name = Myapp
  Include {
    Options {
      Signature = SHA1
    }
     $source_path
    }
   }"
  $content_storage = "Device {
  Name = FileStorage
  Media Type = File
  Archive Device = $backup_path
  LabelMedia = yes;                   # lets Bareos label unlabeled media
  Random Access = yes;
  AutomaticMount = yes;               # when device opened, read it
  RemovableMedia = no;
  AlwaysOpen = yes;
  }"
  $content_schedule = "Schedule {
  Name = TenMinutes
  Run = Level=$b_level hourly at 0:05
  Run = Level=$b_level hourly at 0:15
  Run = Level=$b_level hourly at 0:25
  Run = Level=$b_level hourly at 0:35
  Run = Level=$b_level hourly at 0:45
  Run = Level=$b_level hourly at 0:55
  }"

file {'/etc/bareos/bareos-dir.d/catalog/MyCatalog.conf':
    ensure => file,
    content => $content,
 notify => Service['bareos-sd', 'bareos-fd', 'bareos-dir'],
  owner => $f_owner,
  group => $f_group,
   mode => $f_mode,
require => Package['bareos'],
}
file {'/etc/bareos/bareos-dir.d/job/myapp.conf':
    ensure => file,
    content => $content_myapp,
 notify => Service['bareos-sd', 'bareos-fd', 'bareos-dir'],
  owner => $f_owner,
  group => $f_group,
   mode => $f_mode,
require => Package['bareos'],
}
file {'/etc/bareos/bareos-dir.d/fileset/Myapp.conf':
    ensure => file,
   content => $content_fileset,
    notify => Service['bareos-sd', 'bareos-fd', 'bareos-dir'],
     owner => $f_owner,
     group => $f_group,
      mode => $f_mode,
   require => Package['bareos'],
}
file {'/etc/bareos/bareos-sd.d/device/FileStorage.conf':
     ensure => file,
     content => $content_storage,
 notify => Service['bareos-sd', 'bareos-fd', 'bareos-dir'],
     owner => $f_owner,
     group => $f_group,
      mode => $f_mode,
   require => Package['bareos'],
}
file {'/etc/bareos/bareos-dir.d/schedule/TenMinutes.conf':
     ensure => file,
    content => $content_schedule,
     notify => Service['bareos-sd', 'bareos-fd', 'bareos-dir'],
      owner => $f_owner,
      group => $f_group,
       mode => $f_mode,
    require => Package['bareos'],
}
}
