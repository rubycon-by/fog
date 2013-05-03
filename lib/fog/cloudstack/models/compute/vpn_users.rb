require 'fog/core/collection'
require 'fog/cloudstack/models/compute/vpn_user'

module Fog
  module Compute
    class Cloudstack

      class VpnUsers < Fog::Collection

        model Fog::Compute::Cloudstack::VpnUser

        def all(attributes={})
          response = service.list_vpn_users attributes
          data = response["listloadbalancerrulesresponse"]["loadbalancerrule"] || []
          load(data)
        end

        def get(user_id)
          if data = service.list_vpn_users('id' => user_id)["listloadbalancerrulesresponse"]["loadbalancerrule"].try(:first)
            new(data)
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end
      end

    end
  end
end