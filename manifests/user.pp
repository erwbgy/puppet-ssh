class ssh::user (
  $allow = [],
  $deny  = [],
) {
  # bob:
  #   allow: [ 'alice', 'bob' ]
  #   deny:  [ 'mallory' ]` 
  $user = $title
  if size($allow) > 0 {
    $a1 = zip($allow, range(1, size($allow)))
    $a2 = flatten($t1)
    $a3 = hash($t2)
    create_resources('ssh::user::entry', $a3, { ensure => 'present' } )
  }
  if size($deny) > 0 {
    $d1 = zip($deny, range(1, size($deny)))
    $d2 = flatten($t1)
    $d3 = hash($t2)
    create_resources('ssh::user::entry', $d3, { ensure => 'absent' } )
  }
}
