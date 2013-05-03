module Fog
  module Compute
    class Cloudstack
      class LoadBalancer < Fog::Model

        identity :id,    :aliases => 'id'
        attribute :name,    :aliases => 'name'
        attribute :public_ip_id,    :aliases => 'publicipid'
        attribute :public_ip,    :aliases => 'publicip'
        attribute :public_port,    :aliases => 'publicport'
        attribute :private_port,    :aliases => 'privateport'
        attribute :algorithm,    :aliases => 'algorithm'
        attribute :account,    :aliases => 'account'
        attribute :domain_id,    :aliases => 'domainid'
        attribute :domain,    :aliases => 'domain'
        attribute :state,    :aliases => 'state'
        attribute :zoneid,    :aliases => 'zoneid'


        def ip
          service.ips.get public_ip_id
        end

        def save
          requires :name, :private_port, :public_port, :algorithm
          lb_ip = service.ips.get(public_ip_id).id
          options = {
            'privateport' => private_port,
            'publicport' => public_port,
            'name' => name,
            'algorithm' => algorithm,
            'publicipid' => lb_ip
          }
          service.create_load_balancer_rule(options)
        end

        def destroy
          requires :id
          service.delete_load_balancer_rule({'id' => self.id})
        end

        def update options
          requires :id
          service.update_load_balancer_rule({'id' => self.id}.merge!(options))
        end

      end  #Ip
    end # Cloudstack
  end # Compute
end # Fog
