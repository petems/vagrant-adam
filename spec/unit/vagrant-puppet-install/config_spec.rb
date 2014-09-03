require_relative '../spec_helper'

describe VagrantPlugins::Adam::Config do
  let(:machine) { double('machine') }
  let(:instance) { described_class.new }

  subject(:config) do
    instance.tap do |o|
      o.provision_url = provision_url if defined?(provision_url)
      o.finalize!
    end
  end

  describe 'defaults' do
    describe '#provision_url' do
      subject { super().provision_url }
      it { should be_nil }
    end
  end

  describe 'setting `provision_url` as a url' do
    let(:provision_url) { 'http://somepath.com/install.sh' }

    describe '#provision_url' do
      subject { super().provision_url }
      it { should eq('http://somepath.com/install.sh') }
    end
  end

  describe 'setting `provision_url` as a url' do
    let(:provision_url) { '/tmp/cool_script.sh' }

    describe '#provision_url' do
      subject { super().provision_url }
      it { should eq('/tmp/cool_script.sh') }
    end
  end

  describe 'validate' do
    it 'should be no-op' do
      expect(subject.validate(machine)).to eq('VagrantPlugins::Adam::Config' => [])
    end
  end

  describe '#validate!' do
    describe 'provision_url validation' do
      {
        'http://somepath.com/install.sh' => {
          description: 'valid provision_url http URL string',
          valid: true
        },
        'https://somepath.com/install.sh' => {
          description: 'valid provision_url http URL string',
          valid: true
        },
        "#{support_path('/scripts/hello_world.sh')}" => {
          description: 'valid provision_url Path string',
          valid: true
        },
        '/file_does_not_exist/foz.sh' => {
          description: 'invalid provision_url URL string',
          valid: false
        },
        'ttp:||fake.ziz' => {
          description: 'invalid provision_url path string',
          valid: false
        }
      }.each_pair do |version_string, opts|
        context "#{opts[:description]}: #{version_string}" do
          let(:provision_url) { version_string }
          if opts[:valid]
            it 'passes' do
              expect { subject.validate!(machine) }.to_not raise_error
            end
          else
            it 'fails' do
              expect { subject.validate!(machine) }.to raise_error(Vagrant::Errors::ConfigInvalid)
            end
          end
        end
      end
    end
  end

end
