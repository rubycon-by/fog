module Fog
  module Compute
    class Cloudstack
      class Real

        # Creates a domain.
        #
        # {CloudStack API Reference}[http://download.cloud.com/releases/2.2.0/api_2.2.4/global_admin/deletePortForwardingRule.html]
        def delete_remote_access_vpn(options={})
          options.merge!(
            'command' => 'deleteRemoteAccessVpn'
          )

          request(options)
        end

      end
    end
  end
end
