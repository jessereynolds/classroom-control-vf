class nginx {

  File {
    owner => 'root',
    group => 'root',
    mode => '0644',
  }
  
  # package nginx
  package {'nginx': 
    ensure => present,
  }
  
  $docroot = '/var/www'
  
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
  file {'/etc/nginx/nginx.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/nginx.conf',
    notify => Service['nginx'],
    require => Package['nginx'],
  }
  
  # config default.conf
  file {'/etc/nginx/conf.d/default.conf':
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
