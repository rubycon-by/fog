require 'fog/core/collection'
require 'fog/cloudstack/models/compute/ip'

module Fog
  module Compute
    class Cloudstack

      class Ips < Fog::Collection

        model Fog::Compute::Cloudstack::Ip

        def all(attributes={})
          p "#{attributes} -- #{@filter_attributes}"
          response = service.list_public_ip_addresses attributes
          data = response["listpublicipaddressesresponse"]["publicipaddress"] || []
          clear
          data.map{|x| new(x)}
        end

        def get(ip_id)
          response = service.list_public_ip_addresses(id: ip_id)
          if ip = response["listpublicipaddressesresponse"]["publicipaddress"].try(:first)
            res = new(ip)
            return self.to_a.include?(res) ? res : nil
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end


        protected

        def scoped_attributes attributes = {}
          attributes.merge(@filter_attributes){|key, new_value, old_value| new_value != old_value ? -1 : new_value }
        end

      end

    end
  end
end