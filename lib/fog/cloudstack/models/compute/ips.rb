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
          if ip = response["listpublicipaddressesresponse"]["publicipaddress"].try(:first)
            res = new(ip)
            return self.to_a.include?(res) ? res : nil
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end


        protected

        def scoped_attributes attributes = {}
          attributes.merge(@filter_attributes){|key, new_value, old_value| new_value != old_value ? -1 : new_value } if @filter_attributes and attributes
        end

      end

    end
  end
end