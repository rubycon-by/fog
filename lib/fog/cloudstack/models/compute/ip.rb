module Fog
  module Compute
    class Cloudstack
      class Ip < Fog::Model
        identity :id,    :aliases => 'id'
        attribute :ip_address,    :aliases => 'ipaddress'
        attribute :allocated,    :aliases => 'allocated'
        attribute :zone_id,    :aliases => 'zoneid'
        attribute :zone_name,    :aliases => 'zonename'
        attribute :is_source_nat,    :aliases => 'issourcenat'
        attribute :account,    :aliases => 'account'
        attribute :domain_id,    :aliases => 'domainid'
        attribute :domain,    :aliases => 'domain'
        attribute :for_virtual_network,    :aliases => 'forvirtualnetwork'
        attribute :is_static_nat,    :aliases => 'isstaticnat'
        attribute :associated_network_id,    :aliases => 'associatednetworkid'
        attribute :network_id,    :aliases => 'networkid'
        attribute :state,    :aliases => 'state'


        def port_forwarding_rules
          requires :id
          service.port_forwarding_rules.all({'ipaddressid' => self.id})
        end

        def load_balancers
          requires :id
          service.load_balancers.all({'publicipid' => self.id})
        end

        def enable_nat server_id
          requires :id
          data = service.enable_static_nat({'ipaddressid' => self.id,'virtualmachineid' => server_id})
        end

        def disable_nat
          requires :id
          data = service.disable_static_nat({'ipaddressid' => self.id})
        end

        def save
          requires :zone_id
          data = service.acquire_ip_address({'zoneid' => self.zone_id})
          # merge_attributes(data['listpublicipaddressesresponse'])
        end

        def destroy
          requires :id
          service.release_ip_address('id' => self.id)
        end

      end  #Ip
    end # Cloudstack
  end # Compute
end # Fog
