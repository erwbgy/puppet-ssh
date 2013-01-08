class ssh::access (
  $allow = [],
  $deny  = [],
) {
  include augeasproviders
  $allow_groups = grep($allow, '/^@')
  $deny_groups  = grep($deny,  '/^@')
  $allow_users  = grep($allow, '/^[^@]')
  $deny_users   = grep($deny,  '/^[^@]')
  create_resources(
    sshd_config,
    { 'AllowGroups' => { 'value' => $allow_groups, '/^@') } }
  )
  create_resources(
    sshd_config,
    { 'DenyGroups'  => { 'value' => $deny_groups, '/^@') } }
  )
  create_resources(
    sshd_config,
    { 'AllowUsers'  => { 'value' => $allow_users, '/^[^@]') } }
  )
  create_resources(
    sshd_config,
    { 'DenyUsers'   => { 'value' => $deny_users, '/^[^@]') } }
  )
}
