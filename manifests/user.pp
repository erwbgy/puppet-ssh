define ssh::user (
  $allow = [],
  $deny  = [],
) {
  $owner = $title
  $allow_list = prefix($allow, "${owner},")
  $deny_list  = prefix($deny,  "${owner},")
  ssh::user_entry { $allow_list: ensure => 'present', }
  ssh::user_entry { $deny_list:  ensure => 'absent',  }
}
