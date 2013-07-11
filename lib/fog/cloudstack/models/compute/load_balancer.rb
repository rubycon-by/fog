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

        def instances
          requires :id
          response = service.list_load_balancer_rule_instances('id' => self.id)
          data = response["listloadbalancerruleinstancesresponse"]["loadbalancerruleinstance"] || []
          service.servers.load(data)
        end

        def ip
          requires :public_ip_id
          service.ips.get public_ip_id
        end

        def assign_instances virtual_machine_ids = []
          requires :id
          data = service.assign_to_load_balancer_rule(self.id, virtual_machine_ids)
          data['assigntoloadbalancerruleresponse']
        end

        def remove_instances virtual_machine_ids = []
          requires :id
          data = service.remove_from_load_balancer_rule(self.id, virtual_machine_ids)
          data['removefromloadbalancerruleresponse']
        end

        def save
          requires :name, :private_port, :public_port, :algorithm, :public_ip_id
          lb_ip = service.ips.get(public_ip_id).id
          options = {
            'privateport' => private_port,
            'publicport' => public_port,
            'name' => name,
            'algorithm' => algorithm,
            'publicipid' => lb_ip
          }
          data = service.create_load_balancer_rule(options)
          if data['createloadbalancerruleresponse'].try(:fetch, 'loadbalancer')
            {'object' => data['createloadbalancerruleresponse']['loadbalancer']}
          else
            {error: data['createloadbalancerruleresponse'].values.first }
          end
        end

        def destroy
          requires :id
          service.delete_load_balancer_rule({'id' => self.id})
        end

        def update options
          requires :id
          service.update_load_balancer_rule({'id' => self.id}.merge!(options))
          data['updateloadbalancerruleresponse']
        end

      end  #Ip
    end # Cloudstack
  end # Compute
end # Fog
