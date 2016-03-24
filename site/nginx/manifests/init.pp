class nginx (
  $root = undef,
) {

  case $::osfamily {
    'RedHat' : {
      $confdir      = '/etc/nginx'
      $logdir       = '/var/log/nginx'
      $nginx_user   = 'nginx'
      $package_name = 'nginx'
      $file_owner   = 'root'
      $file_group   = 'root'
      #$docroot      = '/var/www'
      $default_docroot = '/var/www'
    }
    'debian' : {
      $confdir      = '/etc/nginx'
      $logdir       = '/var/log/nginx'
      $nginx_user   = 'www-data'
      $package_name = 'nginx'
      $file_owner   = 'root'
      $file_group   = 'root'
      #$docroot      = '/var/www'
      $default_docroot = '/var/www'
    }
    'windows' : {
      $confdir      = 'C:/ProgramData/nginx/html'
      $logdir       = 'C:/ProgramData/nginx/logs'
      $nginx_user   = 'nobody'
      $package_name = 'nginx-service'
      $file_owner   = 'Administrator'
      $file_group   = 'Administrators'
      #$docroot      = 'C:/ProgramData/nginx/html'
      $default_docroot = 'C:/ProgramData/nginx/html'
    }
    default : {
      fail("nginx module does not support operating system ${::osfamily}")
    }
  }
  
  $docroot = $root ? {
    undef   => $default_docroot,
    default => $root,
  }
  
  File {
    owner => $file_owner,
    group => $file_group,
    mode => '0644',
  }
  
  # package nginx
  package {'nginx': 
    ensure => present,
    name   => $package_name,
  }
  
  # document root /var/www
  file {$docroot:
    ensure => directory,
  }
  
  # index.html
  file {"${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  
  # config file nginx.conf
  file {"${confdir}/nginx.conf":
    ensure => file,
    source => 'puppet:///modules/nginx/nginx.conf',
    notify => Service['nginx'],
    require => Package['nginx'],
  }
  
  # config default.conf
  file {"${confdir}/conf.d/default.conf":
    ensure => file,
    source => 'puppet:///modules/nginx/default.conf',
    notify => Service['nginx'],
    require => Package['nginx'],
  }
  
  # service
  service {'nginx':
    ensure => running,
    enable => true,
  }
}
