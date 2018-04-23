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
  $user         = 'r10k',
  $home         = '/var/lib/r10k',
  $allowed_keys = [],
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
  ssh::key {"${home}/.ssh/id_rsa":
    user    => $user,
    length  => 4096,
    require => File["${home}/.ssh"],
  }
  ssh::key {"${home}/.ssh/id_ed25519":
    type    => 'ed25519',
    user    => $user,
    require => File["${home}/.ssh"],
  }

  #keys which are allowed to login:
  ssh::authorized_key{'allowed keys for r10k update':
    username => $user,
    keys     => $allowed_keys,
  }

  # scipts to execute by gitolite hook
  file {"${home}/update_environment.sh":
    owner   => $user,
    group   => $user,
    mode    => '0755',
    content => template('r10k/update_environment.sh.erb'),
  }

  file {"${home}/update_module.sh":
    owner  => $user,
    group  => $user,
    mode   => '0755',
    content => template('r10k/update_module.sh.erb'),
  }
}
