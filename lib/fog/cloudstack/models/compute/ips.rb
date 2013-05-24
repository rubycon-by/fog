require 'fog/core/collection'
require 'fog/cloudstack/models/compute/ip'

module Fog
  module Compute
    class Cloudstack

      class Ips < Fog::Collection

        model Fog::Compute::Cloudstack::Ip

        def all(attributes={})
          response = service.list_public_ip_addresses scoped_attributes(attributes)
          data = response["listpublicipaddressesresponse"]["publicipaddress"] || []
          @filter_attributes ||= attributes.except("command", "response", "sessionkey")
          load(data)
        end

        def get(ip_id)
          response = service.list_public_ip_addresses(scoped_attributes(id: ip_id))
          ip = response["listpublicipaddressesresponse"]["publicipaddress"].try(:first)
          new(ip) if ip
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end
      end

    end
  end
end