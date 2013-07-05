module Fog
  module Compute
    class Cloudstack
      class Real

        # Creates an account.
        #
        # {CloudStack API Reference}[http://download.cloud.com/releases/2.2.0/api_2.2.4/global_admin/associateIpAddress.html]
        def add_vpn_user(options={})
          options.merge!(
            'command' => 'addVpnUser'
          )

          request(options)
        end

      end
    end
  end
end

