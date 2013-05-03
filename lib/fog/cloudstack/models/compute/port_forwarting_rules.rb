require 'fog/core/collection'
require 'fog/cloudstack/models/compute/port_forwarting_rule'

module Fog
  module Compute
    class Cloudstack

      class PortForwartingRules < Fog::Collection

        model Fog::Compute::Cloudstack::PortForwartingRule

        def all(attributes={})
          response = service.list_port_forwarding_rules attributes
          data = response["listportforwardingrulesresponse"]["portforwardingrule"] || []
          load(data)
        end

        def get(rule_id)
          if ip = service.list_port_forwarding_rules('id' => rule_id)["listportforwardingrulesresponse"]["portforwardingrule"].try(:first)
            new(ip)
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end
      end

    end
  end
end