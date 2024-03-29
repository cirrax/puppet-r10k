# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

* [`r10k`](#r10k): Main r10k class
* [`r10k::authorized_key`](#r10k--authorized_key): Define an authorized key on the server
* [`r10k::gitolite_hooks`](#r10k--gitolite_hooks): this class installs hooks on a gitolite server to trigger r10k updates
* [`r10k::ssh_key`](#r10k--ssh_key): Generate an SSH authentication key  Key generation for (passwordless) authentication to a remote system.
* [`r10k::user`](#r10k--user): this class creates an r10k user with ssh key etc.

## Classes

### <a name="r10k"></a>`r10k`

Main r10k class

#### Parameters

The following parameters are available in the `r10k` class:

* [`configdir`](#-r10k--configdir)
* [`ensure_configdir`](#-r10k--ensure_configdir)
* [`cachedir`](#-r10k--cachedir)
* [`pool_size`](#-r10k--pool_size)
* [`proxy`](#-r10k--proxy)
* [`deploy`](#-r10k--deploy)
* [`sources`](#-r10k--sources)
* [`git`](#-r10k--git)
* [`forge`](#-r10k--forge)
* [`user`](#-r10k--user)
* [`home`](#-r10k--home)
* [`ensure_user`](#-r10k--ensure_user)
* [`allowed_keys`](#-r10k--allowed_keys)
* [`packages`](#-r10k--packages)
* [`package_ensure`](#-r10k--package_ensure)
* [`package_options`](#-r10k--package_options)
* [`r10k_command`](#-r10k--r10k_command)

##### <a name="-r10k--configdir"></a>`configdir`

Data type: `String`

where the configfile should be put
defaults to '/etc/puppet'

Default value: `'/etc/puppet'`

##### <a name="-r10k--ensure_configdir"></a>`ensure_configdir`

Data type: `Boolean`

set this to true to ensure the config direcory exists

Default value: `false`

##### <a name="-r10k--cachedir"></a>`cachedir`

Data type: `Optional[String[1]]`

The 'cachedir' setting controls where cached content, such as mirrored Git
repositories, are stored on the local machine. This location should be
persistent, as environments and modules may rely on these files in order to
be updated.

Default value: `undef`

##### <a name="-r10k--pool_size"></a>`pool_size`

Data type: `Optional[Integer]`

The pool_size setting is a number to determine how many threads should
be spawn while updating modules.

Default value: `undef`

##### <a name="-r10k--proxy"></a>`proxy`

Data type: `Optional[String[1]]`

The 'proxy' setting configures an HTTP proxy to use for all HTTP/HTTPS
operations performed by r10k. This includes requests to the Puppet Forge
as well as any Git operations performed against an HTTP/HTTPS remote.
@see https://github.com/puppetlabs/r10k/blob/main/doc/dynamic-environments/configuration.mkd#proxy

Default value: `undef`

##### <a name="-r10k--deploy"></a>`deploy`

Data type: `Optional[Hash]`

Top level setting for controlling how r10k deploys behave.
@see https://github.com/puppetlabs/r10k/blob/main/doc/dynamic-environments/configuration.mkd#deploy
Example (hiera, yaml):
  r10k::deploy:
    generate_types: true

Default value: `undef`

##### <a name="-r10k--sources"></a>`sources`

Data type: `Optional[Hash]`

Hash of sources to use, defaults to {}
@see https://github.com/puppetlabs/r10k/blob/main/doc/dynamic-environments/configuration.mkd#source-options
Example (hiera):
  r10k::sources:
    main-puppet:
      remote: 'git@somewhere:main-puppet'
      basedir: '/etc/puppet/environments'

Default value: `undef`

##### <a name="-r10k--git"></a>`git`

Data type: `Optional[Hash]`

Hash of git configurations, defaults to {}
See r10k.yaml file for possible options (section git)

Default value: `undef`

##### <a name="-r10k--forge"></a>`forge`

Data type: `Optional[Hash]`

Hash of forge configurations, defaults to {}
See r10k.yaml file for possible options (section forge)

Default value: `undef`

##### <a name="-r10k--user"></a>`user`

Data type: `String`

the r10k user, defaults to 'r10k'

Default value: `'r10k'`

##### <a name="-r10k--home"></a>`home`

Data type: `String`

the home directory of $user

Default value: `'/var/lib/r10k'`

##### <a name="-r10k--ensure_user"></a>`ensure_user`

Data type: `Boolean`

if we should ensure the r10k user
(if true, includes r10k::user)
defaults to true

Default value: `true`

##### <a name="-r10k--allowed_keys"></a>`allowed_keys`

Data type: `Array`

Array of ssh keys allowed to execute r10k updates
normaly this is the key used by git hooks.

Default value: `[]`

##### <a name="-r10k--packages"></a>`packages`

Data type: `Array`

packages to install

Default value: `['r10k']`

##### <a name="-r10k--package_ensure"></a>`package_ensure`

Data type: `String[1]`

what to ensure for packages

Default value: `'installed'`

##### <a name="-r10k--package_options"></a>`package_options`

Data type: `Hash[String[1],String[1]]`

options to set for the package option used to
install $packages.
eg. this lets you install r10k from gem by
setting this to:
{ 'provider' => 'gem' }

Default value: `{}`

##### <a name="-r10k--r10k_command"></a>`r10k_command`

Data type: `String[1]`

r10k command, if it is not saved in path,
you can specify the command with the path

Default value: `'r10k'`

### <a name="r10k--authorized_key"></a>`r10k::authorized_key`

Define an authorized key on the server

#### Parameters

The following parameters are available in the `r10k::authorized_key` class:

* [`username`](#-r10k--authorized_key--username)
* [`home`](#-r10k--authorized_key--home)
* [`keys`](#-r10k--authorized_key--keys)
* [`destination`](#-r10k--authorized_key--destination)
* [`owner`](#-r10k--authorized_key--owner)
* [`group`](#-r10k--authorized_key--group)
* [`mode`](#-r10k--authorized_key--mode)
* [`command`](#-r10k--authorized_key--command)
* [`options`](#-r10k--authorized_key--options)

##### <a name="-r10k--authorized_key--username"></a>`username`

Data type: `String[1]`

the username to put the file for

##### <a name="-r10k--authorized_key--home"></a>`home`

Data type: `String[1]`

the users homedirectory

##### <a name="-r10k--authorized_key--keys"></a>`keys`

Data type: `Array`

an array of keys to concat

Default value: `[]`

##### <a name="-r10k--authorized_key--destination"></a>`destination`

Data type: `Optional[String[1]]`

use this if you want to set a different destination than
'~/.ssh/authorized_keys'

Default value: `undef`

##### <a name="-r10k--authorized_key--owner"></a>`owner`

Data type: `String[1]`

owner for the authorized_keys file

Default value: `$username`

##### <a name="-r10k--authorized_key--group"></a>`group`

Data type: `String[1]`

group for the authorized_keys file

Default value: `$username`

##### <a name="-r10k--authorized_key--mode"></a>`mode`

Data type: `String[1]`

mode for the authorized_keys file

Default value: `'0644'`

##### <a name="-r10k--authorized_key--command"></a>`command`

Data type: `String[1]`

command to allow
defaults to '/var/lib/r10k/update_environment.sh'

Default value: `'/var/lib/r10k/update_environment.sh'`

##### <a name="-r10k--authorized_key--options"></a>`options`

Data type: `Array`

defaults to: [no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty]

Default value: `['no-port-forwarding','no-X11-forwarding','no-agent-forwarding','no-pty']`

### <a name="r10k--gitolite_hooks"></a>`r10k::gitolite_hooks`

this class installs hooks on a gitolite server
to trigger r10k updates

#### Parameters

The following parameters are available in the `r10k::gitolite_hooks` class:

* [`hook_path`](#-r10k--gitolite_hooks--hook_path)
* [`hook_name`](#-r10k--gitolite_hooks--hook_name)
* [`multihook_name`](#-r10k--gitolite_hooks--multihook_name)
* [`multihook_scripts`](#-r10k--gitolite_hooks--multihook_scripts)
* [`gitolite_user`](#-r10k--gitolite_hooks--gitolite_user)
* [`packages`](#-r10k--gitolite_hooks--packages)

##### <a name="-r10k--gitolite_hooks--hook_path"></a>`hook_path`

Data type: `String`

path where to install the hooks
defaults to: '/var/lib/gitolite/scripts'

Default value: `'/var/lib/gitolite/scripts'`

##### <a name="-r10k--gitolite_hooks--hook_name"></a>`hook_name`

Data type: `String`

filename of the update hook script

Default value: `'update-r10k-branch'`

##### <a name="-r10k--gitolite_hooks--multihook_name"></a>`multihook_name`

Data type: `String`

filename of the mutlihook script
set to '' if you do not want to install
defaults to: '/var/lib/gitolite/scripts/multihook_r10k_email'

Default value: `'multihook_r10k_email'`

##### <a name="-r10k--gitolite_hooks--multihook_scripts"></a>`multihook_scripts`

Data type: `Array`

Array of scripts installed in $hook_path to
execute with multihook.
defaults to []
$hook_name is added by default.

Default value: `[]`

##### <a name="-r10k--gitolite_hooks--gitolite_user"></a>`gitolite_user`

Data type: `String`

gitolite user to be owner of the scripts
defaults to 'gitolite'

Default value: `'gitolite'`

##### <a name="-r10k--gitolite_hooks--packages"></a>`packages`

Data type: `Array`

additional packages needed for the hooks
defaults to ['moreutils'] which contains pee needed for multihook

Default value: `['moreutils']`

### <a name="r10k--ssh_key"></a>`r10k::ssh_key`

Generate an SSH authentication key

Key generation for (passwordless) authentication to a
remote system.

#### Parameters

The following parameters are available in the `r10k::ssh_key` class:

* [`filename`](#-r10k--ssh_key--filename)
* [`type`](#-r10k--ssh_key--type)
* [`length`](#-r10k--ssh_key--length)
* [`password`](#-r10k--ssh_key--password)
* [`comment`](#-r10k--ssh_key--comment)
* [`user`](#-r10k--ssh_key--user)

##### <a name="-r10k--ssh_key--filename"></a>`filename`

Data type: `String`

Filename (full path) for the key. Required.

##### <a name="-r10k--ssh_key--type"></a>`type`

Data type: `String`

Type of key, either dsa, ecdsa or rsa. Defaults to rsa.

Default value: `'rsa'`

##### <a name="-r10k--ssh_key--length"></a>`length`

Data type: `Integer`

Key length. Defaults to 2048. See man ssh-keygen for restrictions
regarding non RSA keys.

Default value: `2048`

##### <a name="-r10k--ssh_key--password"></a>`password`

Data type: `String`

Password for the key. Defaults to no password. This is not very secure
as the password is visible in plain text in the puppet manifest and as a
process parameters when creating the key.

Default value: `''`

##### <a name="-r10k--ssh_key--comment"></a>`comment`

Data type: `String`

Comment describing the Key. Defaults to "Automatic authentication key for $user on $fqdn".

Default value: `'undef'`

##### <a name="-r10k--ssh_key--user"></a>`user`

Data type: `String`

User who uses this key. This user must have write access to the directory
containing the key. Defaults to "root"

Default value: `'root'`

### <a name="r10k--user"></a>`r10k::user`

this class creates an r10k user
with ssh key etc.

#### Parameters

The following parameters are available in the `r10k::user` class:

* [`user`](#-r10k--user--user)
* [`home`](#-r10k--user--home)
* [`allowed_keys`](#-r10k--user--allowed_keys)

##### <a name="-r10k--user--user"></a>`user`

Data type: `String`

the r10k user, defaults to 'r10k'

Default value: `'r10k'`

##### <a name="-r10k--user--home"></a>`home`

Data type: `String`

the home directory of $user

Default value: `'/var/lib/r10k'`

##### <a name="-r10k--user--allowed_keys"></a>`allowed_keys`

Data type: `Array`

Array of ssh keys allowed to execute r10k updates
normaly this is the key used by git hooks.

Default value: `[]`

