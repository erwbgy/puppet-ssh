define ssh::key_entry (
  $ensure = 'present',
) {
  $user = $title
  $key = hiera_hash( "ssh::keys::${user}" )
  if $key {
    ssh_authorized_key { "${user}@${::hostname}":
      ensure => $ensure,
      key    => $key[public_key],
      type   => $key[type],
      user   => $user,
    }
  }
  else {
    notify { "SSH key config for ${user} not found": }
  }
}
