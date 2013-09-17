module Fog
  module Compute
    class Cloudstack
      class Real
        def update_load_balancer_rule(options = {})
          options.merge!(
            'command' => 'updateLoadBalancerRule'
          )
          request(options)
        end
      end
    end
  end
end