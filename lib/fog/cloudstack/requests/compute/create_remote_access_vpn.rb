module Fog
  module Compute
    class Cloudstack
      class Real

        def create_remote_access_vpn(options={})
          options.merge!(
            'command' => 'createRemoteAccessVpn'
          )

          request(options)
        end

      end
    end
  end
end
