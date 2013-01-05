class ssh::access (
  $group = 'sshusers',
  $gid   = undef,
  $allow = [],
  $deny  = [],
) {
  include augeasproviders
  create_resources(
    sshd_config, 
    { 'AllowGroups' => { 'value' => [ $group ] } }
  )
  if ! defined(Group[$group]) {
    if $gid {
      group { $group: gid     => $gid, }
    }
    else {
      group { $group: system  => true, }
    }
  }
  ssh::group_member { $allow:
    group   => $group,
    ensure  => present,
    require => Group[$group],
  }
  ssh::group_member { $deny:
    group   => $group,
    ensure  => absent,
    require => Group[$group],
  }
}
