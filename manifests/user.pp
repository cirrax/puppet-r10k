#
# this class creates an r10k user
# with ssh key etc.
#
# Parameters:
# $user:
#   the r10k user, defaults to 'r10k'
# $home:
#   the home directory of $user
# $allowed_keys:
#   Array of ssh keys allowed to execute r10k updates
#   normaly this is the key used by git hooks.
#
class r10k::user (
  String $user         = 'r10k',
  String $home         = '/var/lib/r10k',
  Array  $allowed_keys = [],
){

  user{ $user:
    ensure     => 'present',
    system     => true,
    comment    => "${user} user",
    managehome => true,
    home       => $home,
    shell      => '/bin/bash',
  }

  file { [$home, "${home}/.ssh"] :
    ensure  => directory,
    owner   => $user,
    group   => $user,
    mode    => '0700',
    require => User[$user],
  }

  #SSH Key to fetch data from git
  class {'::r10k::ssh_key':
    filename => "${home}/.ssh/id_ed25519",
    type     => 'ed25519',
    user     => $user,
    require  => File["${home}/.ssh"],
  }

  #keys which are allowed to login:
  class {'::r10k::authorized_key':
    username => $user,
    keys     => $allowed_keys,
    home     => $home,
  }
}
