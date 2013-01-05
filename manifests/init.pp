class ssh {
  include ssh::access
  $users = hiera_hash('ssh_users', undef)
  if $users {
    create_resources('ssh::user', $users, undef)
  }
}
