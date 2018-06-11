#
# Define an authorized key on the server
#
# Parameters:
#   $username:
#     the username to put the file for
#   $home:
#     the users homedirectory
#   $keys
#     an array of keys to concat
#   $destination
#     use this if you want to set a different destination than
#     '~/.ssh/authorized_keys'
#   $command
#     command to allow
#     defaults to '/var/lib/r10k/update_environment.sh'
#   $options
#     defaults to: [no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty]
#

class r10k::authorized_key (
  $username,
  $home,      
  $keys        = [],
  $destination = '',
  $owner       = $username,
  $group       = $username,
  $mode        = '0644',
  $command     = '/var/lib/r10k/update_environment.sh',
  $options     = ['no-port-forwarding','no-X11-forwarding','no-agent-forwarding','no-pty']
) {

  $_keys = prefix(prefix($keys,' '), join(["command=\"${command}\"", join($options,',')],','))

  if $destination == '' {
    file { "${home}/.ssh/authorized_keys":
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      content => join($_keys, "\n"),
      require => File["${home}/.ssh/"],
    }
  } else {
    file { $destination:
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      content => join($_keys, "\n"),
    }
  }
}
