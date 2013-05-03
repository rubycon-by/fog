require 'fog/core/collection'
require 'fog/cloudstack/models/compute/balancer_instance'

module Fog
  module Compute
    class Cloudstack

      class BalancerInstances < Fog::Collection

        model Fog::Compute::Cloudstack::BalancerInstance

        def all(attributes={})
          response = service.list_load_balancer_rule_instances(attributes)
          data = response["listloadbalancerruleinstancesresponse"]["loadbalancerruleinstance"] || []
          load(data)
        end

        def get(instance_id)
          if data = service.list_load_balancer_rules('id' => instance_id)["listloadbalancerruleinstancesresponse"]["loadbalancerruleinstance"].try(:first)
            new(data)
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end
      end

    end
  end
end