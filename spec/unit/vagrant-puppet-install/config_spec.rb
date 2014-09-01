require_relative '../spec_helper'
#
describe VagrantPlugins::Adam::Config do
  let(:machine) { double('machine') }
  let(:instance) { described_class.new }

  subject(:config) do
    instance.tap do |o|
      o.provision_url = install_url if defined?(install_url)
      o.finalize!
    end
  end

  describe 'defaults' do
    its(:provision_url) { should be_nil }
  end

    describe 'validate' do
    it 'should be no-op' do
      expect(subject.validate(machine)).to eq('VagrantPlugins::Adam::Config' => [])
    end
  end

end
