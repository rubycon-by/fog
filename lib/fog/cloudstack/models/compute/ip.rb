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


        def vpn_enabled?
          requires :id
          response = service.list_remote_access_vpns({'publicipid' => self.id})
          data = response['listremoteaccessvpnsresponse']['remoteaccessvpn']
          res = data ? data.first.fetch('presharedkey') : false
        end

        def enable_vpn
          requires :id
          service.create_remote_access_vpn({'publicipid' => self.id})
        end

        def disable_vpn
          requires :id
          service.delete_remote_access_vpn({'publicipid' => self.id})
        end

        def port_forwarding_rules
          requires :id
          service.port_forwarding_rules.all({'ipaddressid' => self.id})
        rescue Fog::Compute::Cloudstack::BadRequest
          []
        end

        def port_range
          requires :id
          data = service.list_ip_forwarding_rules({'ipaddressid' => self.id})
          data = data['listipforwardingrulesresponse']['ipforwardingrule'] || []
          PortForwardingRules.new.load data
        rescue Fog::Compute::Cloudstack::BadRequest
          []  
        end

        def load_balancers
          requires :id
          service.load_balancers.all({'publicipid' => self.id})
        end

        def static_nat_enabled?
          requires :is_static_nat
          self.is_static_nat
        end

        def source_nat?
          requires :is_source_nat
          self.is_source_nat
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
          data['associateipaddressresponse']
          # merge_attributes(data['listpublicipaddressesresponse'])
        end

        def destroy
          requires :id
          data = service.release_ip_address('id' => self.id)
          data['disassociateipaddressresponse']
        end

      end  #Ip
    end # Cloudstack
  end # Compute
end # Fog
