class ssh {
  include ssh::access
  $users = hiera_hash('ssh::users', undef)
  if $users {
    create_resources('ssh::user', $users)
  }
}
