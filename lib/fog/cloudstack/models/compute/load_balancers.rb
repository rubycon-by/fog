require 'fog/core/collection'
require 'fog/cloudstack/models/compute/load_balancer'

module Fog
  module Compute
    class Cloudstack

      class LoadBalancers < Fog::Collection

        model Fog::Compute::Cloudstack::LoadBalancer


        def all(attributes={})
          response = service.list_load_balancer_rules scoped_attributes(attributes)
          data = response["listloadbalancerrulesresponse"]["loadbalancerrule"] || []
          condition = @filter_attributes.nil?
          @filter_attributes = attributes.except("command", "response", "sessionkey") if @filter_attributes.nil?
          load(data, condition)
        end

        def get(balance_id)
          if data = balance_id.nil? ? nil : service.list_load_balancer_rules(scoped_attributes(id: balance_id))["listloadbalancerrulesresponse"]["loadbalancerrule"].try(:first)
            new(data)
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end
      end

    end
  end
end