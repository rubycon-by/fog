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


        def save
          requires :private_port, :public_port, :protocol, :virtual_machine_id
          options = {
            'privateport' => private_port,
            'publicport' => public_port,
            'protocol' => protocol,
            'virtualmachineid' => virtual_machine_id,
            'ipaddressid' => self.id
          }
          service.create_port_forwarting_rule(options)
        end

        def destroy
          requires :id
          service.delete_port_forwarting_rule({'id' => rule_id})
        end

      end  #Ip
    end # Cloudstack
  end # Compute
end # Fog
