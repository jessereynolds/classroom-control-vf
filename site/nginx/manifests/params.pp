class nginx::params {

  case $::osfamily {
    'RedHat' : {
      $confdir      = '/etc/nginx'
      $logdir       = '/var/log/nginx'
      $nginx_user   = 'nginx'
      $package_name = 'nginx'
      $file_owner   = 'root'
      $file_group   = 'root'
      $docroot      = '/var/www'
    }
    'debian' : {
      $confdir      = '/etc/nginx'
      $logdir       = '/var/log/nginx'
      $nginx_user   = 'www-data'
      $package_name = 'nginx'
      $file_owner   = 'root'
      $file_group   = 'root'
      $docroot      = '/var/www'
    }
    'windows' : {
      $confdir      = 'C:/ProgramData/nginx/html'
      $logdir       = 'C:/ProgramData/nginx/logs'
      $nginx_user   = 'nobody'
      $package_name = 'nginx-service'
      $file_owner   = 'Administrator'
      $file_group   = 'Administrators'
      $docroot      = 'C:/ProgramData/nginx/html'
    }
    default : {
      fail("nginx module does not support operating system ${::osfamily}")
    }
  }

}
