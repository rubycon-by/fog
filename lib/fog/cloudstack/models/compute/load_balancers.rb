require 'fog/core/collection'
require 'fog/cloudstack/models/compute/load_balancer'

module Fog
  module Compute
    class Cloudstack

      class LoadBalancers < Fog::Collection

        model Fog::Compute::Cloudstack::LoadBalancer

        alias_method :find, :get

        def all(attributes={})
          response = service.list_load_balancer_rules attributes
          data = response["listloadbalancerrulesresponse"]["loadbalancerrule"] || []
          load(data)
        end

        def get(balance_id)
          if data = service.list_load_balancer_rules('id' => balance_id)["listloadbalancerrulesresponse"]["loadbalancerrule"].try(:first)
            new(data)
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end
      end

    end
  end
end