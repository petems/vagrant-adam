require_relative '../../spec_helper'
require 'vagrant-adam/action/pre_provision_script'

describe VagrantPlugins::Adam::Action::PreProvisionScript do
  let(:app) { lambda { |_env| } }
  let(:env) { { machine: machine, tmp_path: ['/vagrant/'], ui: ui } }
  let(:ui) do
    double('ui').tap { |_ui| machine.stub(config: config, communicate: communicate, info: info) }
  end
  let(:info) { double('info') }
  let(:vm) { true }
  let(:machine) do
    double('machine').tap { |machine| machine.stub(config: config, communicate: communicate) }
  end
  let(:communicate) do
    double('communicate').tap { |machine| machine.stub(upload: upload) }
  end
  let(:upload) do
    double('upload')
  end
  let(:config) do
    double('config').tap { |config| config.stub(adam: adam, vm: vm) }
  end
  let(:vm) do
    double('vm').tap { |config| config.stub(guest: 'guest') }
  end
  let(:adam) do
    double('adam').tap { |config| config.stub(:finalize! => true, :provision_url => '/tmp/config.sh') }
  end

  describe '#initialize' do
    subject { described_class.new(app, env) }
    it { should be_a described_class }
  end

  describe '#call' do
    context 'when called' do
      subject(:pre_provision_script) { described_class.new(app, env) }
      it 'should fetch the script, then run it' do
        expect(pre_provision_script).to receive(:fetch_or_create_pre_provision_script).with(env)
        expect(pre_provision_script).to receive(:run_provision_script).with(env)
        pre_provision_script.call(env)
      end
    end
  end

end
