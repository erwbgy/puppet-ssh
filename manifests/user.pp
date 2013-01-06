define ssh::user (
  $allow = [],
  $deny  = [],
) {
  $user = $title
  ssh::user_entry { $allow: ensure => 'present' }
  ssh::user_entry { $deny:  ensure => 'absent' }
}
