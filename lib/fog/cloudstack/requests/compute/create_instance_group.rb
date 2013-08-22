module Fog
  module Compute
    class Cloudstack
      class Real

        # Deletes a specified user.
        #
        # {CloudStack API Reference}[http://download.cloud.com/releases/2.2.0/api_2.2.4/global_admin/deleteUser.html]
        def create_instance_group(options={})
          options.merge!(
            'command' => 'createInstanceGroup'
          )

          request(options)
        end

      end
    end
  end
end
