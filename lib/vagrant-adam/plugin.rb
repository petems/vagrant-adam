module VagrantPlugins
  module Adam
    # Plugin definition for Plugin meta-data and to check Vagrant version
    # meets given requirement. We also define action_hooks to decide when actions occur
    class Plugin < Vagrant.plugin('2')
      VAGRANT_VERSION_REQUIREMENT = '>= 1.1.0'

      name 'vagrant-adam'
      description <<-DESC
      This plugin ensures a pre-provision script is run before anything else
      DESC

      # Returns true if the Vagrant version fulfills the requirements
      #
      # @param requirements [String, Array<String>] the version requirement
      # @return [Boolean]
      def self.check_vagrant_version(*requirements)
        Gem::Requirement.new(*requirements).satisfied_by?(
          Gem::Version.new(Vagrant::VERSION))
      end

      # Verifies that the Vagrant version fulfills the requirements
      #
      # @raise [VagrantPlugins::ProxyConf::VagrantVersionError] if this plugin
      # is incompatible with the Vagrant version
      def self.check_vagrant_version!
        unless check_vagrant_version(VAGRANT_VERSION_REQUIREMENT)
          msg = I18n.t(
            'vagrant_adam.errors.vagrant_version',
            requirement: VAGRANT_VERSION_REQUIREMENT.inspect)
          $stderr.puts msg
          fail msg
        end
      end

      action_hook(:pre_provision_script, Plugin::ALL_ACTIONS) do |hook|
        hook.after(Vagrant::Action::Builtin::SyncedFolders, Action::PreProvisionScript)
        require_relative 'action/pre_provision_script'
      end

      config(:adam) do
        require_relative 'config'
        Config
      end
    end
  end
end
