require 'fog/core/collection'
require 'fog/cloudstack/models/compute/ip'

module Fog
  module Compute
    class Cloudstack

      class Ips < Fog::Collection

        model Fog::Compute::Cloudstack::Ip

        def all(attributes={})
          response = service.list_public_ip_addresses attributes
          data = response["listpublicipaddressesresponse"]["publicipaddress"] || []
          load(data)
        end

        def get(ip_id)
          if ip = service.list_public_ip_addresses('id' => ip_id)["listpublicipaddressesresponse"]["publicipaddress"].try(:first)
            new(ip)
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end
      end

    end
  end
end