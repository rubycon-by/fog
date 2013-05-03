module Fog
  module Compute
    class Cloudstack
      class PortForwardingRule < Fog::Model

        identity :id,    :aliases => 'id'
        attribute :private_port,    :aliases => 'privateport'
        attribute :private_end_port,    :aliases => 'privateendport'
        attribute :protocol,    :aliases => 'protocol'
        attribute :public_port,    :aliases => 'publicport'
        attribute :public_end_port,    :aliases => 'publicendport'
        attribute :virtual_machine_id,    :aliases => 'virtualmachineid'
        attribute :virtual_machine_name,    :aliases => 'virtualmachinename'
        attribute :virtual_machine_display_name,    :aliases => 'virtualmachinedisplayname'
        attribute :ip_address_id,    :aliases => 'ipaddressid'
        attribute :ip_address,    :aliases => 'ipaddress'
        attribute :state,    :aliases => 'state'
        attribute :cidrlist,    :aliases => 'cidrlist'


        def ip
          service.ips.get ip_address_id
        end

        def save pfr_ip_address = nil
          requires :private_port, :public_port, :protocol, :virtual_machine_id
          pfr_ip = service.ips.get(ip_address_id).id || pfr_ip_address
          options = {
            'privateport' => private_port,
            'publicport' => public_port,
            'protocol' => protocol,
            'virtualmachineid' => virtual_machine_id,
            'ipaddressid' => pfr_ip
          }
          service.create_port_forwarding_rule(options)
        end

        def destroy
          requires :id
          service.delete_port_forwarding_rule({'id' => self.id})
        end

      end  #Ip
    end # Cloudstack
  end # Compute
end # Fog
