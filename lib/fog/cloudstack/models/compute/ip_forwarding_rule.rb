module Fog
  module Compute
    class Cloudstack
      class IpForwardingRule < Fog::Model

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
        attribute :start_port,    :aliases => 'startport'
        attribute :end_port,    :aliases => 'endport'


        def ip
          service.ips.get ip_address_id
        end

        def save pfr_ip_address = nil
          requires :ip_address_id, :private_port, :public_port, :protocol, :virtual_machine_id
          pfr_ip = service.ips.get(ip_address_id).try(:id) || pfr_ip_address
          options = {
            'startport' => private_port,
            'endport' => public_port,
            'protocol' => protocol,
            'ipaddressid' => pfr_ip
          }
          data = service.create_ip_forwarding_rule(options)
          data['createipforwardingruleresponse']
        end

        def destroy
          requires :id
          data = service.delete_ip_forwarding_rule({'id' => self.id})
          data['deleteipforwardingruleresponse']
        end

      end  #Ip
    end # Cloudstack
  end # Compute
end # Fog
