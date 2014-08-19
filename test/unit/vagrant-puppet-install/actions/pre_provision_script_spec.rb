require_relative '../../spec_helper'
require 'vagrant-adam/action/pre_provision_script'

describe VagrantPlugins::Adam::Action::PreProvisionScript do
  let(:app) { lambda { |env| } }
  let(:env) { { :machine => machine, :tmp_path => ['/vagrant/'] } }
  let(:vm) { true }
  let(:machine) do
    double('machine').tap { |machine| machine.stub(:config).and_return(config) }
  end
  let(:config) do
    double('config').tap { |config| config.stub(:adam => adam) }
  end
  let(:adam) do
    double('adam').tap { |config| config.stub(:finalize! => true, :provision_url => '/tmp/config.sh') }
  end

  describe "#initialize" do
    subject { described_class.new(app, env) }
    it { should be_a VagrantPlugins::Adam::Action::PreProvisionScript }
  end

  describe "#find_provision_script" do
    context 'should get provision script location from centos.adam.provision_url config value' do
      subject { described_class.new(app, env).find_provision_script }
      it { should eql '/tmp/config.sh' }
    end

    context 'should get provision script location from ENV variable first' do
      before { ENV.stub(:[]).with("PRE_PROV_URL").and_return("/tmp/env.sh") }
      subject { described_class.new(app, env).find_provision_script }
      it { should eql '/tmp/env.sh' }
    end
  end

end