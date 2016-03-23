class users::admins {
  $users = ['jose', 'alice', 'chen']
  users::managed_user {$users: }
  
  #users::managed_user {'jose': }
  #users::managed_user {'alice': }
  #users::managed_user {'chen': }
}
