class ssh::access (
  $allow = [],
  $deny  = [],
) {
  include augeasproviders
  $allow_groups = regsubst( grep($allow, '^@'), '^@(.*)$', '\1' )
  $deny_groups  = regsubst( grep($deny,  '^@'), '^@(.*)$', '\1' )
  $allow_users  = grep($allow, '^[^@]')
  $deny_users   = grep($deny,  '^[^@]')
  if size($allow_groups) > 0 {
    create_resources(
      sshd_config,
      { 'AllowGroups' => { 'value' => $allow_groups, } }
    )
  }
  if size($deny_groups) > 0 {
    create_resources(
      sshd_config,
      { 'DenyGroups'  => { 'value' => $deny_groups, } }
    )
  }
  if size($allow_users) > 0 {
    create_resources(
      sshd_config,
      { 'AllowUsers'  => { 'value' => $allow_users, } }
    )
  }
  if size($allow_groups) > 0 {
    create_resources(
      sshd_config,
      { 'DenyUsers'   => { 'value' => $deny_users, } }
    )
  }
}
