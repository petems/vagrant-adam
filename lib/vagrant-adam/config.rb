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

        if (@provision_url != nil)
          unless (valid_uri? @provision_url) || (valid_file? @provision_url)
            msg = <<-EOH
'#{ @provision_url }' is not a valid filepath or URL
            EOH
            errors << msg
          end
        end

        if errors.any?
          rendered_errors = Vagrant::Util::TemplateRenderer.render(
                              'config/validation_failed',
                              errors: { 'vagrant-adam' => errors }
                            )
          fail Vagrant::Errors::ConfigInvalid, errors: rendered_errors
        end
      end

      private

      def valid_uri? value
        begin
          uri = URI.parse value
          uri.kind_of?(URI::HTTP) or uri.kind_of?(URI::HTTPS)
        rescue URI::InvalidURIError
          false
        end
      end

      def valid_file? value
        File.file?(value)
      end

    end
  end
end
