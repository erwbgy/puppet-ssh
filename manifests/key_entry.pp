define ssh::key_entry (
  $ensure,
) {
  $a = split($title, ',')
  $owner = $a[0]
  $user  = $a[1]
  $key = hiera_hash( "ssh::keys::${user}" )
  if $key {
    ssh_authorized_key { "${user}-key-${ensure}-in-${owner}@${::hostname}":
      ensure => $ensure,
      key    => $key[public_key],
      type   => $key[type],
      user   => $owner,
    }
  }
  else {
    notify { "SSH key config for ${user} not found": }
  }
}
