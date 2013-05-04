module Fog
  module Compute
    class Cloudstack
      class Real

        def list_remote_access_vpns(options={})
          options.merge!(
            'command' => 'listRemoteAccessVpns'
          )

          request(options)
        end

      end
    end
  end
end
