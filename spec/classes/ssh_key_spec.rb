
require 'spec_helper'

describe 'r10k::ssh_key' do

  let :default_params do
     { :filename => '/tmp/ssh_key',
       :type     => 'rsa',
       :length   => 2048,
       :password => '',
       :comment  => 'undef',
       :user     => 'root',
     }
  end

  shared_examples 'r10k::ssh_key shared examples' do
    it { is_expected.to compile.with_all_deps }
    
    it { is_expected.to contain_exec('key for r10k' )
      .with_path(["/usr/bin", "/usr/sbin", "/bin"])
      .with_user(params[:user])
      .with_creates(params[:filename])
      .with_command(/^ssh-keygen -t/) 
    }
  end

  context 'with defaults' do
    let :params do
      default_params
    end
    it_behaves_like 'r10k::ssh_key shared examples'
  end

  context 'with non defaults' do
    let :params do
      default_params.merge(
        :filename => '/tmp/another_location',
        :type     => 'ecdsa',
        :length   => 4000,
        :password => 'password',
        :comment  => 'somecomment',
        :user     => 'r10k',
      )
    end
    it_behaves_like 'r10k::ssh_key shared examples'
  end

end


