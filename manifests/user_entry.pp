define ssh::user_entry (
  $ensure,
) {
  create_resources('ssh::key_entry',
    {
      "${title}" => {
        'ensure' => $ensure,
      }
    }
  )
}
