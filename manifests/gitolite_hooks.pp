#
# this class installs the scripts  
# for the hook
#
class r10k::gitolite_hooks (
  $hook_path     = '/var/lib/gitolite/scripts',
  $gitolite_user = 'gitolite',
){

  file {"${hook_path}/multihook_r10k_email":
    owner   => $gitolite_user,
    mode    => '0755',
    source  => 'puppet:///modules/r10k/multihook_r10k_email',
    require => File[$hook_path],
  }

  file {"${hook_path}/update-r10k-branch":
    owner   => $gitolite_user,
    mode    => '0755',
    source  => 'puppet:///modules/r10k/update-r10k-branch',
    require => File[$hook_path],
  }
}
