require 'fog/core/collection'
require 'fog/cloudstack/models/compute/balancer_instance'

module Fog
  module Compute
    class Cloudstack

      class BalancerInstances < Fog::Collection

        model Fog::Compute::Cloudstack::BalancerInstance

        def all(balancer_id, attributes={})
          response = service.list_load_balancer_rule_instances balancer_id, attributes
          data = response["listloadbalancerruleinstancesresponse"]["loadbalancerruleinstance"] || []
          load(data)
        end

        def get(balance_id)
          if data = service.list_load_balancer_rules('id' => balance_id)["listloadbalancerruleinstancesresponse"]["loadbalancerruleinstance"].try(:first)
            new(data)
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end
      end

    end
  end
end