module Fog
  module Compute
    class Cloudstack
      class Ip < Fog::Model
        attribute :id,    :aliases => 'id'
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
        # identity  :id,                          :aliases => 'id'
        # attribute :name
        # attribute :display_name,                :aliases => 'displayname'
        # attribute :account,                     :aliases => 'account'
        # attribute :domain_id,                   :aliases => 'domainid'
        # attribute :domain,                      :aliases => 'domain'
        # attribute :created
        # attribute :state
        # attribute :ha_enable,                   :aliases => 'haenable'
        # attribute :group_id,                    :aliases => 'groupid'
        # attribute :zone_id,                     :aliases => 'zoneid'
        # attribute :zone_name,                   :aliases => 'zonename'
        # attribute :template_id,                 :aliases => 'templateid'
        # attribute :template_name,               :aliases => 'templatename'
        # attribute :template_display_text,       :aliases => 'templatedisplaytext'
        # attribute :password_enabled,            :aliases => 'passwordenabled'
        # attribute :service_offering_id,         :aliases => 'serviceofferingid'
        # attribute :service_offering_name,       :aliases => 'serviceofferingname'
        # attribute :cpu_number,                  :aliases => 'cpunumber'
        # attribute :cpu_speed,                   :aliases => 'cpuspeed'
        # attribute :memory
        # attribute :cpu_used,                    :aliases => 'cpuused'
        # attribute :network_kbs_read,            :aliases => 'networkkbsread'
        # attribute :network_kbs_write,           :aliases => 'networkkbswrite'
        # attribute :guest_os_id,                 :aliases => 'guestosid'
        # attribute :root_device_id,              :aliases => 'rootdeviceid'
        # attribute :root_device_type,            :aliases => 'rootdevicetype'
        # attribute :security_group,              :aliases => 'securitygroup'
        # attribute :nic
        # attribute :hypervisor


        def enable_nat server_id
          requires :id
          data = service.enable_static_nat({'virtualmachineid' => server_id})
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
