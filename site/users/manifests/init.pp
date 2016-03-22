class users {

  user {'fundamentals':
    ensure => present,
    managehome => true,
  }

}
