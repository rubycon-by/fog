require 'fog/core/collection'
require 'fog/cloudstack/models/compute/ip'

module Fog
  module Compute
    class Cloudstack

      class Ips < Fog::Collection

        model Fog::Compute::Cloudstack::Ip

        def all(attributes={})
          response = service.list_public_ip_addresses @filter_attributes.merge!(attributes)
          data = response["listpublicipaddressesresponse"]["publicipaddress"] || []
          load(data)
        end

        def get(ip_id)
          response = service.list_public_ip_addresses({id: ip_id}.merge!(@filter_attributes){|key, new_value, old_value| new_value != old_value ? -1 : new_value })
          if ip = response["listpublicipaddressesresponse"]["publicipaddress"].try(:first)
            new(ip)
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end
      end

    end
  end
end