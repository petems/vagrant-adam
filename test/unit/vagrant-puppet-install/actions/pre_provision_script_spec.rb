require_relative '../../spec_helper'
require 'vagrant-adam/action/pre_provision_script'

describe VagrantPlugins::Adam::Action::PreProvisionScript do
  let(:app) { nil }
  let(:env) { {} }
  subject(:action) { described_class.new(app, env) }

  describe '#run_provision_script' do
    context 'with no config setting' do
      it { should eql [] }
    end
  end
end