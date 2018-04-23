#
# this class installs hooks on a gitolite server
# to trigger r10k updates
#
# Parameters:
# $hook_path:
#   path where to install the hooks
#   defaults to: '/var/lib/gitolite/scripts'
# $hook_name:
#   filename of the update hook script
# $multihook_name:
#   filename of the mutlihook script
#   set to '' if you do not want to install
#   defaults to: '/var/lib/gitolite/scripts/multihook_r10k_email'
# $multihook_scripts:
#   Array of scripts installed in $hook_path to
#   execute with multihook.
#   defaults to []
#   $hook_name is added by default.
# $gitolite_user:
#   gitolite user to be owner of the scripts
#   defaults to 'gitolite'
#
class r10k::gitolite_hooks (
  String $hook_path         = '/var/lib/gitolite/scripts',
  String $hook_name         = 'update-r10k-branch',
  String $multihook_name    = 'multihook_r10k_email',
  Array  $multihook_scripts = [],
  String $gitolite_user     = 'gitolite',
){

  if $hook_name != '' {
    file { "${hook_path}/${hook_name}":
      owner  => $gitolite_user,
      mode   => '0755',
      source => 'puppet:///modules/r10k/update-r10k-branch',
    }
  }

  if $multihook_name != '' {
    $prefixed_multihook_scripts = prefix($multihook_scripts, '$P/')
    file { "${hook_path}/${multihook_name}":
      owner   => $gitolite_user,
      mode    => '0755',
      content => template('r10k/gitolite/multihook_r10k_email.erb'),
    }
  }
}
