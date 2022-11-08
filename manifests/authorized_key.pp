#
# Define an authorized key on the server
#
# @param username
#   the username to put the file for
# @param home
#   the users homedirectory
# @param keys
#   an array of keys to concat
# @param destination
#   use this if you want to set a different destination than
#   '~/.ssh/authorized_keys'
# @param owner
#   owner for the authorized_keys file
# @param group
#   group for the authorized_keys file
# @param mode
#   mode for the authorized_keys file
# @param command
#   command to allow
#   defaults to '/var/lib/r10k/update_environment.sh'
# @param options
#   defaults to: [no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty]
#
class r10k::authorized_key (
  String[1]           $username,
  String[1]           $home,
  Array               $keys        = [],
  Optional[String[1]] $destination = undef,
  String[1]           $owner       = $username,
  String[1]           $group       = $username,
  String[1]           $mode        = '0644',
  String[1]           $command     = '/var/lib/r10k/update_environment.sh',
  Array               $options     = ['no-port-forwarding','no-X11-forwarding','no-agent-forwarding','no-pty']
) {
  $_keys = prefix(prefix($keys,' '), join(["command=\"${command}\"", join($options,',')],','))

  if $destination {
    file { $destination:
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      content => join($_keys, "\n"),
    }
  } else {
    file { "${home}/.ssh/authorized_keys":
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      content => join($_keys, "\n"),
      require => File["${home}/.ssh"],
    }
  }
}
