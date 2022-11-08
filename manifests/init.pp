#
# Main r10k class
#
# @param configdir
#   where the configfile should be put
#   defaults to '/etc/puppet'
# @param cachedir
#   The 'cachedir' setting controls where cached content, such as mirrored Git
#   repositories, are stored on the local machine. This location should be
#   persistent, as environments and modules may rely on these files in order to
#   be updated.
# @param proxy
#   The 'proxy' setting configures an HTTP proxy to use for all HTTP/HTTPS
#   operations performed by r10k. This includes requests to the Puppet Forge
#   as well as any Git operations performed against an HTTP/HTTPS remote.
# @param sources
#   Hash of sources to use, defaults to {}
#   Example (hiera):
#     r10k::sources:
#       main-puppet:
#         remote: 'git@somewhere:main-puppet'
#         basedir: '/etc/puppet/environments'
# @param git
#   Hash of git configurations, defaults to {}
#   See r10k.yaml file for possible options (section git)
# @param forge
#   Hash of forge configurations, defaults to {}
#   See r10k.yaml file for possible options (section forge)
# @param user
#   the r10k user, defaults to 'r10k'
# @param home
#   the home directory of $user
# @param ensure_user
#   if we should ensure the r10k user
#   (if true, includes r10k::user)
#   defaults to true
# @param allowed_keys
#   Array of ssh keys allowed to execute r10k updates
#   normaly this is the key used by git hooks.
#
class r10k (
  String  $configdir    = '/etc/puppet',
  String  $cachedir     = '',
  String  $proxy        = '',
  Hash    $sources      = {},
  Hash    $git          = {},
  Hash    $forge        = {},
  String  $user         = 'r10k',
  String  $home         = '/var/lib/r10k',
  Boolean $ensure_user  = true,
  Array   $allowed_keys = [],
) {
  if $ensure_user {
    class { 'r10k::user':
      user         => $user,
      home         => $home,
      allowed_keys => $allowed_keys,
    }
  }

  package { 'r10k':
    ensure => 'installed',
  }

  file { "${configdir}/r10k.yaml":
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('r10k/r10k.yaml.erb'),
  }

  # scipts to execute to update environments (usally through hook)
  file { "${home}/update_environment.sh":
    owner   => $user,
    group   => $user,
    mode    => '0755',
    content => template('r10k/update_environment.sh.erb'),
  }

  file { "${home}/update_module.sh":
    owner   => $user,
    group   => $user,
    mode    => '0755',
    content => template('r10k/update_module.sh.erb'),
  }
}
