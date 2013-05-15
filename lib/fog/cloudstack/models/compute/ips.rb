require 'fog/core/collection'
require 'fog/cloudstack/models/compute/ip'

module Fog
  module Compute
    class Cloudstack

      class Ips < Fog::Collection

        model Fog::Compute::Cloudstack::Ip

        def all(attributes={})
          p @filter_attributes
          response = service.list_public_ip_addresses scoped_attributes(attributes)
          data = response["listpublicipaddressesresponse"]["publicipaddress"] || []
          load(data)
        end

        def get(ip_id)
          p @filter_attributes
          response = service.list_public_ip_addresses(scoped_attributes({id: ip_id}))
          if ip = response["listpublicipaddressesresponse"]["publicipaddress"].try(:first)
            new(ip)
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end

        protected

        def scoped_attributes attributes = {}
          # p attributes
          p @filter_attributes
          t = attributes.merge!(@filter_attributes){|key, new_value, old_value| new_value != old_value ? -1 : new_value }
          # p t
          t
        end

      end

    end
  end
end