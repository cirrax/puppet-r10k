
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
    #it { is_expected.to compile }
    #it { is_expected.to contain_user( params[:user] )
    # .with_ensure( 'present' )
    # .with_system( true )
    # .with_managehome( true )
    # .with_home( params[:home] )
    # .with_shell( '/bin/bash' )
    # .with_comment ( params[:user] + ' user' )
    #}


  end

  context 'with defaults' do
    let :params do
      default_params
    end
    it_behaves_like 'r10k::user shared examples'
  end
end
