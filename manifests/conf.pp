class bareos::conf {
file {'/etc/bareos/bareos-dir.d/catalog/MyCatalog.conf':
    ensure => file,
    content => 'catalog {
Name = MyCatalog
dbuser = bareos
dbname = bareos
dbdriver = mysql
dbpassword = bareos
}',
notify => Service['bareos-sd', 'bareos-fd', 'bareos-dir'],
}
file {'/etc/bareos/bareos-dir.d/schedule/TenMinutes.conf':
    ensure => file,
    content => 'Schedule {
  Name = "TenMinutes"
  Run = Level=Full hourly at 0:05
  Run = Level=Full hourly at 0:15
  Run = Level=Full hourly at 0:25
  Run = Level=Full hourly at 0:35
  Run = Level=Full hourly at 0:45
  Run = Level=Full hourly at 0:55
}',
notify => Service['bareos-sd', 'bareos-fd', 'bareos-dir'],
}
file {'/etc/bareos/bareos-dir.d/job/myapp.conf':
    ensure => file,
    content => 'Job {
  Name = "BackupApp"
  Description = "Backup some app"
  JobDefs = "DefaultJob"
  Client = bareos-fd
  Level = Full
  FileSet="Myapp"
  Schedule = "TenMinutes"
}',
notify => Service['bareos-sd', 'bareos-fd', 'bareos-dir'],
}
file {'/etc/bareos/bareos-dir.d/fileset/Myapp.conf':
    ensure => file,
    content => 'FileSet {
  Name = Myapp
  Include {
    Options {
      Signature = SHA1
    }
     File = /var/lib/mysql
    }
}',
notify => Service['bareos-sd', 'bareos-fd', 'bareos-dir'],
}
file {'/etc/bareos/bareos-sd.d/device/FileStorage.conf':
     ensure => file,
     content => 'Device {
  Name = FileStorage
  Media Type = File
  Archive Device = /home/ubuntu/test

  LabelMedia = yes;                   # lets Bareos label unlabeled media
  Random Access = yes;
  AutomaticMount = yes;               # when device opened, read it
  RemovableMedia = no;
  AlwaysOpen = yes;
  Description = "File device. A connecting Director must have the same Name and MediaType."
}',
notify => Service['bareos-sd', 'bareos-fd', 'bareos-dir'],
}
}
