require 'fog/core/collection'
require 'fog/cloudstack/models/compute/ip'

module Fog
  module Compute
    class Cloudstack

      class Ips < Fog::Collection

        model Fog::Compute::Cloudstack::Ip

        def initialize args
          p "tt = #{args}"

          p "tt = #{args.class}"
          super
        end

        def all(attributes={})
          p "#{attributes} -- #{@filter_attributes}"
          response = service.list_public_ip_addresses attributes
          data = response["listpublicipaddressesresponse"]["publicipaddress"] || []
          load(data)
        end

        def get(ip_id)
          response = service.list_public_ip_addresses(scoped_attributes(id: ip_id))
          if ip = response["listpublicipaddressesresponse"]["publicipaddress"].try(:first)
            new(ip)
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