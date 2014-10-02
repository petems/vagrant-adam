require 'log4r'
require 'shellwords'
require 'fog'

require 'vagrant/util/downloader'

module VagrantPlugins
  module Adam
    module Action
      # This action uploads then runs a given script on the Vagrant environment
      class PreProvisionScript
        def initialize(app, env)
          @app = app
          @logger =
            Log4r::Logger.new('vagrantplugins::adam::action::preprovisionscript')
          @machine = env[:machine]
          @provision_script = find_provision_script
          @machine.config.adam.finalize!
        end

        def call(env)
          @app.call(env)
          return unless @machine.communicate.ready? && provision_enabled?(env)
          fetch_or_create_pre_provision_script(env)
          run_provision_script(env)
          recover(env)
        end

        private

        def find_provision_script
          config_provision_script_url || env_provision_url
        end

        def windows_guest?
          @machine.config.vm.guest.eql?(:windows)
        end

        def config_provision_script_url
          @machine.config.adam.provision_url
        end

        def env_provision_url
          ENV['PRE_PROV_URL']
        end

        def provision_script_name
          if windows_guest?
            # No Windows Version yet
          else
            'prov_script.sh'
          end
        end

        def provision_enabled?(env)
          env.fetch(:provision_enabled, true)
        end

        #
        # Upload provision script from Host's Vagrant TMP directory to guest
        # and executes.
        #
        def run_provision_script(env)
          @machine.communicate.tap do |comm|
            comm.upload(@script_tmp_path, provision_script_name)
            if windows_guest?
              # Not sure yet...
            else
              provision_cmd = "sh #{provision_script_name}"
              provision_cmd << ' 2>&1'
            end
            env[:ui].info(I18n.t('vagrant_adam.pre_provision_script_start'))
            comm.sudo(provision_cmd) do |type, data|
              if [:stderr, :stdout].include?(type)
                env[:ui].info(data)
              end
            end
            env[:ui].info(I18n.t('vagrant_adam.pre_provision_script_finish'))
          end
        end

        #
        # Fetches or creates a provision script to the Host's
        # Vagrant TMP directory.
        #
        def fetch_or_create_pre_provision_script(env)
          @script_tmp_path =
            env[:tmp_path].join("#{Time.now.to_i}-#{provision_script_name}")

          @logger.info("Generating provision script at: #{@script_tmp_path}")

          url = @provision_script

          if File.file?(url) || url !~ /^[a-z0-9]+:.*$/i
            @logger.info('Assuming URL is a file.')
            file_path = File.expand_path(url)
            file_path = Vagrant::Util::Platform.cygwin_windows_path(file_path)
            url = "file:#{file_path}"
          end

          # Download the provision script to a temporary path.
          # We store the temporary path as an instance variable so that
          # the `#recover` method can access it.
          begin
            if windows_guest?
              # Not sure how to do this in Windows yet...
            else
              downloader = Vagrant::Util::Downloader.new(
                url,
                @script_tmp_path,
                {}
              )
              downloader.download!
            end
          rescue Vagrant::Errors::DownloaderInterrupted
            # The downloader was interrupted, so just return, because that
            # means we were interrupted as well.
            env[:ui].info(I18n.t('vagrant-adam.download.interrupted'))
            return
          end
        end

        def recover(env)
          if @script_tmp_path && File.exist?(@script_tmp_path)
            File.unlink(@script_tmp_path)
          end
        end
      end
    end
  end
end
