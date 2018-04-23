
require 'spec_helper'

describe 'r10k' do
  let :default_params do
     { 
       :configdir    => '/etc/puppet',
       :cachedir     => '',
       :proxy        => '',
       :sources      => {},
       :git          => {},
       :forge        => {},
       :user         => 'r10k',
       :home         => '/var/lib/r10k',
       :ensure_user  => false, # defaults to true but needs compile fix
       :allowed_keys => [],
     }
  end

  shared_examples 'r10k shared examples' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_package( 'r10k' )
      .with_ensure( 'installed' )	 
    }

    it { is_expected.to contain_file( params[:configdir] + '/r10k.yaml' )
      .with_owner( 'root' )
      .with_group( 'root' )
      .with_mode( '0644' )
    }

    it { is_expected.to contain_file( params[:home] + '/update_environment.sh' )
      .with_owner( params[:user] )
      .with_group( params[:user] )
      .with_mode( '0755' )
    }

    it { is_expected.to contain_file( params[:home] + '/update_module.sh' )
      .with_owner( params[:user] )
      .with_group( params[:user] )
      .with_mode( '0755' )
    }


  end

  context 'with defaults' do
    let :params do
      default_params
    end
    it_behaves_like 'r10k shared examples'
  end

  context 'with non default configdir' do
    let :params do
      default_params.merge(
        :configdir => '/somewhere_else',
      )
    end
    it_behaves_like 'r10k shared examples'
  end

  context 'with non default user' do
    let :params do
      default_params.merge(
        :user => 'r42k',
	:home => '/somewhere',
      )
    end
    it_behaves_like 'r10k shared examples'
  end
end
