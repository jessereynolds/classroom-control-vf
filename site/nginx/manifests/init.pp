class nginx {
  # package nginx
  package {'nginx': 
    ensure => present,
  }
  
  # document root /var/www
  file {'/var/www':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755',
  }
  
  # index.html
  file {'/var/www/index.html':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/nginx/index.html',
  }
  
  # config file nginx.conf
  file {'/etc/nginx/nginx.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/nginx/nginx.conf',
    notify => Service['nginx'],
    require => Package['nginx'],
  }
  
  # config default.conf
  file {'/etc/nginx/conf.d/default.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
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
