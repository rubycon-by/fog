module Fog
  module Compute
    class Cloudstack
      class Real

        def list_vpn_users(options={})
          options.merge!(
            'command' => 'listVpnUsers'
          )

          request(options)
        end

      end
    end
  end
end
