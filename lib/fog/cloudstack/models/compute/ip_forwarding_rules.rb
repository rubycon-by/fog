require 'fog/core/collection'
require 'fog/cloudstack/models/compute/ip_forwarding_rule'

module Fog
  module Compute
    class Cloudstack

      class IpForwardingRules < Fog::Collection

        model Fog::Compute::Cloudstack::IpForwardingRule

        alias_method :get, :find

        def all(attributes={})
          response = service.list_ip_forwarding_rules attributes
          data = response["listipforwardingrulesresponse"]["ipforwardingrule"] || []
          condition = @filter_attributes.nil?
          @filter_attributes = attributes.except("command", "response", "sessionkey") if @filter_attributes.nil?
          load(data, condition)
        end

        def get(rule_id)
          if rule = service.list_ip_forwarding_rules('id' => rule_id)["listipforwardingrulesresponse"]["ipforwardingrule"].try(:first)
            new(rule)
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end
      end

    end
  end
end