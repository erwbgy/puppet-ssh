define ssh::user_entry (
  $ensure = 'present',
) {
  $user = $title
  create_resources('ssh::key_entry', { "${user}" => { 'ensure' => $ensure } } )
}
