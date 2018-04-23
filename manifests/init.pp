#
# Parameters:
#  $configdir:
#    where the configfile should be put
#    defaults to '/etc/puppet'
#  $cachedir:
#    The 'cachedir' setting controls where cached content, such as mirrored Git
#    repositories, are stored on the local machine. This location should be
#    persistent, as environments and modules may rely on these files in order to
#    be updated.
#  $proxy:
#    The 'proxy' setting configures an HTTP proxy to use for all HTTP/HTTPS
#    operations performed by r10k. This includes requests to the Puppet Forge
#    as well as any Git operations performed against an HTTP/HTTPS remote.
#  $sources:
#    Hash of sources to use, defaults to {}
#    Example (hiera):
#      r10k::sources:
#        main-puppet:
#          remote: 'git@somewhere:main-puppet'
#          basedir: '/etc/puppet/environments'
#  $git:
#    Hash of git configurations, defaults to {}
#    See r10k.yaml file for possible options (section git)
#  $forge:
#    Hash of forge configurations, defaults to {}
#    See r10k.yaml file for possible options (section forge)
#
class r10k (
  String $configdir = '/etc/puppet',
  String $cachedir  = '',
  String $proxy     = '',
  Hash   $sources   = {},
  Hash   $git       = {},
  Hash   $forge     = {},
){

  package { 'r10k':
    ensure => 'installed',
  }

  file { "${configdir}/r10k.yaml":
    owner => 'root',
    group => 'root',
    mode  => '0644',
    content => template('r10k/r10k.yaml.erb'),
  }
}
