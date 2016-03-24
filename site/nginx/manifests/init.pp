class nginx (
  $confdir      = $nginx::params::confdir
  $logdir       = $nginx::params::logdir
  $nginx_user   = $nginx::params::nginx_user
  $package_name = $nginx::params::package_name
  $file_owner   = $nginx::params::file_owner
  $file_group   = $nginx::params::file_group
  $docroot      = $nginx::params::docroot
) inherits nginx::params {
  
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
  
  file {"${confdir}/conf.d":
    ensure => directory,
  }
  
  # config file nginx.conf
  file {"${confdir}/nginx.conf":
    ensure => file,
    #source => 'puppet:///modules/nginx/nginx.conf',
    content => template('nginx/nginx.conf.erb'),
    notify => Service['nginx'],
    require => Package['nginx'],
  }
  
  # config default.conf
  file {"${confdir}/conf.d/default.conf":
    ensure => file,
    #source => 'puppet:///modules/nginx/default.conf',
    content => template('nginx/default.conf.erb'),
    notify => Service['nginx'],
    require => Package['nginx'],
  }
  
  # service
  service {'nginx':
    ensure => running,
    enable => true,
  }
}
