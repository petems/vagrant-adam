require_relative '../../spec_helper'
require 'vagrant-adam/action/pre_provision_script'

describe VagrantPlugins::Adam::Action::PreProvisionScript do
  let(:app) { nil }
  let(:env) { {} }
  subject(:action) { described_class.new(app, env) }

  describe '#run_provision_script' do
    context 'with ENV defined script' do
      before { ENV.stub(:[]).with("PRE_PROV_URL").and_return("/tmp/test.sh") }
      it { should eql [] }
    end
  end
end