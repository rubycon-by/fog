module Fog
  module Compute
    class Cloudstack
      class Real
        def remove_vpn_user(options={})
          options.merge!(
            'command' => 'removeVpnUser'
          )

          request(options)
        end

      end
    end
  end
end
