require 'vagrant'

module VagrantPlugins
  module Adam
    class Config < Vagrant.plugin('2', :config)
      attr_accessor :provision_url

      def initialize
        @provision_url = UNSET_VALUE
        @logger = Log4r::Logger.new('vagrantplugins::adam::config')
      end

      def finalize!
        @provision_url = nil if @provision_url == UNSET_VALUE
      end

      def validate!(machine)
        finalize!
        errors = []
      end

    end
  end
end
