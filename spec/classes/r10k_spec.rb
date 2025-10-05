# frozen_string_literal: true

require 'spec_helper'

describe 'r10k' do
  let :default_params do
    {
      configdir: '/etc/puppet',
      sources: {},
      git: {},
      forge: {},
      user: 'r10k',
      home: '/var/lib/r10k',
      ensure_user: true,
      allowed_keys: [],
    }
  end

  shared_examples 'r10k shared examples' do
    it { is_expected.to compile.with_all_deps }

    it {
      is_expected.to contain_package('r10k')
        .with_ensure('installed')
    }

    it {
      is_expected.to contain_file("#{params[:configdir]}/r10k.yaml")
        .with_owner('root')
        .with_group('root')
        .with_mode('0644')
    }

    it {
      is_expected.to contain_file("#{params[:home]}/update_environment.sh")
        .with_owner(params[:user])
        .with_group(params[:user])
        .with_mode('0755')
    }

    it {
      is_expected.to contain_file("#{params[:home]}/update_module.sh")
        .with_owner(params[:user])
        .with_group(params[:user])
        .with_mode('0755')
    }
  end

  shared_examples 'r10k user' do
    it {
      is_expected.to contain_class('r10k::user')
        .with_user(params[:user])
        .with_home(params[:home])
        .with_allowed_keys(params[:allowed_keys])
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with defaults' do
        let :params do
          default_params
        end

        it_behaves_like 'r10k shared examples'
      end

      context 'with non default configdir' do
        let :params do
          default_params.merge(
            configdir: '/somewhere_else'
          )
        end

        it_behaves_like 'r10k shared examples'
        it_behaves_like 'r10k user'
      end

      context 'with package_options' do
        let :params do
          default_params.merge(
            package_options: { 'provider' => 'gem' }
          )
        end

        it_behaves_like 'r10k shared examples'
        it {
          is_expected.to contain_package('r10k')
            .with_provider('gem')
        }
      end

      context 'with non default user' do
        let :params do
          default_params.merge(
            user: 'r42k',
            home: '/somewhere',
            allowed_keys: ['key']
          )
        end

        it_behaves_like 'r10k shared examples'
        it_behaves_like 'r10k user'
      end

      context 'with ensure_user false' do
        let :params do
          default_params.merge(
            ensure_user: false
          )
        end

        it_behaves_like 'r10k shared examples'
        it {
          is_expected.not_to contain_class('r10k::user')
        }
      end
    end
  end
end
