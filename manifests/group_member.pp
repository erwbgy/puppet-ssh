define ssh::group_member (
  $group,
  $ensure,
) {
  $user = $title
  case $ensure {
    present: {
      exec { "add-${user}-to-group-${group}":
        command => "/usr/sbin/groupmems -g ${group} -a ${user}",
        unless  => "/usr/sbin/groupmems -g sshusers -l | /bin/grep -w ${user}",
      }
      #exec { "add-${user}-to-group-${group}":
      #  command => "/usr/sbin/usermod -a -G ${group} ${user}",
      #  unless  => "/usr/bin/perl -e '$members = (getgrnam($ARGV[0]))[3]; foreach (split(/\s+/,$members)) { exit(0) if $_ eq $ARGV[1]; }; exit(1)' ${user}",
      #}
    }
    absent: {
      exec { "del-${user}-from-group-${group}":
        command => "/usr/sbin/groupmems -g $group -d $user",
        onlyif  => "/usr/sbin/groupmems -g sshusers -l | /bin/grep -w ${user}",
      }
    }
  }
}
