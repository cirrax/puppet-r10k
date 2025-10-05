# frozen_string_literal: true

require 'spec_helper'

describe 'r10k::gitolite_hooks' do
  let :default_params do
    {
      hook_path: '/var/lib/gitolite/scripts',
      hook_name: 'update-r10k-branch',
      multihook_name: 'multihook_r10k_email',
      multihook_scripts: [],
      gitolite_user: 'gitolite',
      packages: ['moreutils'],
    }
  end

  shared_examples 'r10k::gitolite_hooks shared examples' do
    it { is_expected.to compile.with_all_deps }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with defaults' do
        let :params do
          default_params
        end

        it_behaves_like 'r10k::gitolite_hooks shared examples'

        it { is_expected.to contain_package('moreutils') }
      end
    end
  end
end
