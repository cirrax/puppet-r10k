
require 'spec_helper'

describe 'r10k::user' do
  let :default_params do
     { 
       :user         => 'r10k',
       :home         => '/var/lib/r10k',
       :allowed_keys => [],
     }
  end

  shared_examples 'r10k::user shared examples' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_user( params[:user] )
      .with_ensure( 'present' )
      .with_system( true )
      .with_managehome( true )
      .with_home( params[:home] )
      .with_shell( '/bin/bash' )
      .with_comment ( params[:user] + ' user' )
    }

    it { is_expected.to contain_file( params[:home] + '/.ssh')
      .with_ensure('directory')
      .with_owner( params[:user])
      .with_group( params[:user])
      .with_mode('0700')
    }


    it { is_expected.to contain_class( 'r10k::ssh_key')
      .with_filename( params[:home] + '/.ssh/id_ed25519')
      .with_type('ed25519')
      .with_user( params[:user])
    }

    it { is_expected.to contain_class( 'r10k::authorized_key')
      .with_username( params[:user])
      .with_keys( params[:allowed_keys])
      .with_home( params[:home] )
    }
  end

  context 'with defaults' do
    let :params do
      default_params
    end
    it_behaves_like 'r10k::user shared examples'
  end

  context 'with non defaults' do
    let :params do
      default_params.merge( :user => 'r42k', :home => '/tmp/blah', :allowed_keys => ['blah', 'fasel'])
    end
    it_behaves_like 'r10k::user shared examples'
  end
end
