require 'fog/compute/models/server'

module Fog
  module Compute
    class Cloudstack
      class Server < Fog::Compute::Server
        identity  :id,                                      :aliases => 'id'
        attribute :name
        attribute :account_name,                            :aliases => 'account'
        attribute :domain_name,                             :aliases => 'domain'
        attribute :created
        attribute :state
        attribute :haenable
        attribute :memory
        attribute :display_name,                            :aliases => 'displayname'
        attribute :domain_id,                               :aliases => 'domainid'
        attribute :host_id,                                 :aliases => 'hostid'
        attribute :host_name,                               :aliases => 'hostname'
        attribute :project_id,                              :aliases => 'projectid'
        attribute :zone_id,                                 :aliases => 'zoneid'
        attribute :zone_name,                               :aliases => 'zonename'
        attribute :image_id,                                :aliases => ['templateid', :template_id]
        attribute :image_name,                              :aliases => ['templatename', :template_name]
        attribute :templated_display_text,                  :aliases => 'templatedisplaytext'
        attribute :password_enabled,                        :aliases => 'passwordenabled'
        attribute :flavor_id,                               :aliases => ['serviceofferingid', :service_offering_id]
        attribute :flavor_name,                             :aliases => ['serviceofferingname', :service_offering_name]
        attribute :cpu_number,                              :aliases => 'cpunumber'
        attribute :cpu_speed,                               :aliases => 'cpuspeed'
        attribute :cpu_used,                                :aliases => 'cpuused'
        attribute :network_kbs_read,                        :aliases => 'networkkbsread'
        attribute :network_kbs_write,                       :aliases => 'networkkbswrite'
        attribute :guest_os_id,                             :aliases => ['guestosid', 'ostypeid']
        attribute :root_device_id,                          :aliases => 'rootdeviceid'
        attribute :root_device_type,                        :aliases => 'rootdevicetype'
        attribute :group
        attribute :key_name,                                :aliases => 'keypair'
        attribute :user_data,                                :aliases => 'userdata'
        attribute :security_group_list,    :type => :array, :aliases => 'securitygroup'
        attribute :nics,                   :type => :array, :aliases => 'nic'

        attr_accessor :network_ids, :disk_offering_id, :ip_address, :ip_to_network_list
        attr_writer :security_group_ids

        def addresses
          nics.map{|nic| Address.new(nic)}
        end

        def guest_os_name
          os = service.list_os_types['listostypesresponse']['ostype'].detect{|os| os['id'] == self.guest_os_id }
          os['description']
        end

        def password
          service.get_vm_password(self.id)
        end

        def reset_password
          requires :id
          data = service.reset_password_for_virtual_machine(id)
          data['resetpasswordforvirtualmachineresponse']
          # job = service.jobs.get data['resetpasswordforvirtualmachineresponse'].fetch('jobid')
          # job.wait_for { ready? }
        end

        def destroy
          requires :id
          data = service.destroy_virtual_machine("id" => id)
          data["destroyvirtualmachineresponse"]
        end

        def flavor
          service.flavors.get(self.flavor_id)
        end

        def flavor=(flavor_id)
          data = service.change_service_for_virtual_machine('id' => self.id, 'serviceofferingid' => flavor_id )
          data["changeserviceforvirtualmachineresponse"]
        end

        def ready?
          state == 'Running'
        end

        def volumes
          service.volumes.all('virtualmachineid' => self.id)
        end

        def snapshots
          volume_ids = volumes.collect(&:id)
          volume_ids.collect{ |id| service.snapshots.all('volumeid' => id) }.flatten
        end

        def create_snapshots_for_root_volume
          volumes = self.volumes.all('type' => 'ROOT')
          volumes.each{|volume| service.snapshots.create('volume_id' => volume.id) }
        end

        def reboot
          requires :id
          data = service.reboot_virtual_machine('id' => self.id) # FIXME: does this ever fail?
          data["rebootvirtualmachineresponse"]
        end

        def security_groups=(security_groups)
          self.security_group_ids= Array(security_groups).map(&:id)
        end

        def security_group_ids
          @security_group_ids || (self.security_group_list || []).map{|sg| sg["id"]}
        end

        def security_groups
          security_group_ids.map{|id| service.security_groups.get(id)}
        end

        def save
          requires :image_id, :flavor_id, :zone_id
          options = {
            'templateid'        => image_id,
            'serviceofferingid' => flavor_id,
            'zoneid'            => zone_id,
            'networkids'        => network_ids,
            'diskofferingid'    => disk_offering_id,
            'displayname'       => display_name,
            'group'             => group,
            'domainid'          => domain_id,
            'hostid'            => host_id,
            'ipaddress'         => ip_address,
            'iptonetworklist'   => ip_to_network_list,
            'projectid'         => project_id,
            'keypair'           => key_name,
            'userdata'           => user_data,
          }

          options.merge!('networkids' => network_ids) if network_ids
          options.merge!('securitygroupids' => security_group_ids) unless security_group_ids.empty?
          data = service.deploy_virtual_machine(options)
          data['deployvirtualmachineresponse']
          # merge_attributes(data['deployvirtualmachineresponse'])
        end

        def update options
          requires :id
          data = service.update_virtual_machine({'id' => self.id}.merge!(options))
          data['updatevirtualmachineresponse']
        end

        def start
          requires :id
          data = service.start_virtual_machine("id" => self.id)
          data["startvirtualmachineresponse"]
        end

        def stop(force=false)
          requires :id
          data = service.stop_virtual_machine("id" => self.id, "force" => force)
          data["stopvirtualmachineresponse"]
        end
      end # Server
    end # Cloudstack
  end # Compute
end # Fog
