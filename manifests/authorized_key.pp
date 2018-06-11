#
# Define an authorized key on the server
# needs puppet > 4 (each used)
#
# Parameters:
#   $username:
#     the username to put the file for
#   $home:
#     the users homedirectory
#   $keys
#     an array of keys to concat
#     (only for puppet agent > 4)
#   $destination
#     use this if you want to set a different destination than
#     '~/.ssh/authorized_keys'
#

class r10k::authorized_key (
  $username,
  $home,      
  $keys        = [],
  $destination = '',
  $owner       = $username,
  $group       = $username,
  $mode        = '0644',
) {

  if $destination == '' {
    file { "${home}/.ssh/authorized_keys":
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      content => join($keys, "\n"),
      require => File["${home}/.ssh/"],
    }
  } else {
    file { $destination:
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      content => join($keys, "\n"),
    }
  }
}
