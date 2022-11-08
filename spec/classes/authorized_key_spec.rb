
require 'spec_helper'

describe 'r10k::authorized_key' do
  let :default_params do
    { username: 'r10k',
      home: '/var/lib/r10k',
      keys: [],
      owner: 'r10k',
      group: 'r10k',
      mode: '0644',
      command: '/var/lib/r10k/update_environment.sh',
      options: ['no-port-forwarding', 'no-X11-forwarding', 'no-agent-forwarding', 'no-pty'] }
  end

  shared_examples 'r10k::authorized_key shared example' do
    it { is_expected.to compile.with_all_deps }

    it {
      is_expected.to contain_file(params[:home] + '/.ssh/authorized_keys')
        .with_owner(params[:owner])
        .with_group(params[:group])
        .with_mode(params[:mode])
    }
  end
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with defaults' do
        let(:pre_condition) { "file{'/var/lib/r10k/.ssh': }" }
        let :params do
          default_params
        end

        it_behaves_like 'r10k::authorized_key shared example'
      end

      context 'with non defaults' do
        let(:pre_condition) { "file{'/var/lib/r10k/.ssh': }" }
        let :params do
          default_params.merge(owner: 'r42k', group: 'r43k', mode: '0777')
        end

        it_behaves_like 'r10k::authorized_key shared example'
      end

      context 'with special destination' do
        let :params do
          default_params.merge(destination: '/tmp/desti')
        end

        it {
          is_expected.to contain_file('/tmp/desti')
            .with_owner(params[:owner])
            .with_group(params[:group])
            .with_mode(params[:mode])
        }
      end
    end
  end
end
