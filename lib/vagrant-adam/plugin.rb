if Vagrant::VERSION < '1.1.0'
  fail 'The Vagrant Adam plugin is only compatible with Vagrant 1.1+'
end

module VagrantPlugins
  module Adam
    class Plugin < Vagrant.plugin('2')
      name 'vagrant-adam'
      description <<-DESC
      This plugin ensures a pre-provision script is run before anything else
      DESC

      action_hook(:pre_provision_script, Plugin::ALL_ACTIONS) do |hook|
        require_relative 'action/pre_provision_script'
        hook.after(Vagrant::Action::Builtin::SyncedFolders, Action::PreProvisionScript)
      end

      config(:adam) do
        require_relative 'config'
        Config
      end
    end
  end
end
