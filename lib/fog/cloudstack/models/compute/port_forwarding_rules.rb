require 'fog/core/collection'
require 'fog/cloudstack/models/compute/port_forwarding_rule'

module Fog
  module Compute
    class Cloudstack

      class PortForwardingRules < Fog::Collection

        model Fog::Compute::Cloudstack::PortForwardingRule

        alias_method :get, :find

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