module Fog
  module Compute
    class Cloudstack
      class BalancerInstance < Fog::Model

        identity :id,    :aliases => 'id'
        attribute :name,    :aliases => 'name'
        attribute :display_name,    :aliases => 'displayname'
        attribute :account,    :aliases => 'account'
        attribute :domain_id,    :aliases => 'domainid'
        attribute :domain,    :aliases => 'domain'
        attribute :created,    :aliases => 'created'
        attribute :state,    :aliases => 'state'
        attribute :haenable,    :aliases => 'haenable'
        attribute :group_id,    :aliases => 'groupid'
        attribute :group,    :aliases => 'group'
        attribute :zone_id,    :aliases => 'zoneid'
        attribute :zone_name,    :aliases => 'zonename'
        attribute :template_id,    :aliases => 'templateid'
        attribute :template_name,    :aliases => 'templatename'
        attribute :template_display_text,    :aliases => 'templatedisplaytext'
        attribute :password_enabled,    :aliases => 'passwordenabled'
        attribute :service_offering_id,    :aliases => 'serviceofferingid'
        attribute :service_offering_name,    :aliases => 'serviceofferingname'
        attribute :cpu_number,    :aliases => 'cpunumber'
        attribute :cpu_speed,    :aliases => 'cpuspeed'
        attribute :memory,    :aliases => 'memory'
        attribute :cpu_used,    :aliases => 'cpuused'
        attribute :network_kbs_read,    :aliases => 'networkkbsread'
        attribute :network_kbs_write,    :aliases => 'networkkbswrite'
        attribute :guest_os_id,    :aliases => 'guestosid'
        attribute :root_device_id,    :aliases => 'rootdeviceid'
        attribute :root_device_type,    :aliases => 'rootdevicetype'
        attribute :security_group,    :aliases => 'securitygroup'
        attribute :nic,    :aliases => 'nic'
        attribute :hypervisor,    :aliases => 'hypervisor'



      end  #Ip
    end # Cloudstack
  end # Compute
end # Fog
