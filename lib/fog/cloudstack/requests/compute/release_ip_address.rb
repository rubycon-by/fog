module Fog
  module Compute
    class Cloudstack
      class Real

        #
        #
        # {CloudStack API Reference}[http://download.cloud.com/releases/2.2.0/api_2.2.4/global_admin/disassociateIpAddress.html]
        def release_ip_address(options={})
          options.merge!(
            'command' => 'disassociateIpAddress'
          )

          request(options)
        end

      end
    end
  end
end

