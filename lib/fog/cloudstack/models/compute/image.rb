module Fog
  module Compute
    class Cloudstack
      class Image < Fog::Model
        identity  :id,                 :aliases => 'id'
        attribute :account
        attribute :account_id,         :aliases => 'accountid'
        attribute :bootable
        attribute :checksum
        attribute :created
        attribute :cross_zones,        :aliases => 'crossZones'
        attribute :details
        attribute :display_text,       :aliases => 'displaytext'
        attribute :domain
        attribute :domain_id,          :aliases => 'domainid'
        attribute :format
        attribute :host_id,            :aliases => 'hostid'
        attribute :host_name,          :aliases => 'hostname'
        attribute :hypervisor
        attribute :job_id,             :aliases => 'jobid'
        attribute :job_status,         :aliases => 'jobstatus'
        attribute :is_extractable,     :aliases => 'isextractable'
        attribute :is_featured,        :aliases => 'isfeatured'
        attribute :is_public,          :aliases => 'ispublic'
        attribute :is_ready,           :aliases => 'isready'
        attribute :name
        attribute :os_type_id,         :aliases => 'ostypeid'
        attribute :os_type_name,       :aliases => 'ostypename'
        attribute :password_enabled,   :aliases => 'ostypename'
        attribute :project
        attribute :project_id,         :aliases => 'projectid'
        attribute :removed
        attribute :size
        attribute :source_template_id, :aliases => 'sourcetemplateid'
        attribute :status
        attribute :template_tag,       :aliases => 'templatetag'
        attribute :template_type,      :aliases => 'templatetype'
        attribute :zone_id,            :aliases => 'zoneid'
        attribute :zone_name,          :aliases => 'zonename'

        attr_accessor :bits, :requires_hvm, :snapshot_id, :url, :virtual_machine_id, :volume_id, :ssh_key_enabled

        def save
          requires :display_text, :name, :os_type_id
          requires_one :volume_id, :snapshot_id

          options = {
            'displaytext'      => display_text,
            'name'             => name,
            'ostypeid'         => os_type_id,
            'bits'             => bits,
            'details'          => details,
            'isfeatured'       => is_featured,
            'ispublic'         => is_public,
            'passwordenabled'  => password_enabled,
            'requireshvm'      => requires_hvm,
            'snapshotid'       => snapshot_id,
            'templatetag'      => template_tag,
            'url'              => url,
            'virtualmachineid' => virtual_machine_id,
            'volumeid'         => volume_id
          }
          data = service.create_template(options)
          merge_attributes(data['createtemplateresponse'])
        end

        def update
          requires :id

          options = {
            'id'               => id,
            'bootable'         => bootable,
            'displaytext'      => display_text,
            'format'           => format,
            'name'             => name,
            'ostypeid'         => os_type_id,
            'passwordenabled'  => password_enabled,
          }

          data = service.update_template(options)
          merge_attributes(data['updatetemplateresponse'])
        end

        def register
          requires :display_text, :format, :hypervisor, :name, :os_type_id, :url, :zone_id

          options = {
            'displaytext'      => display_text,
            'format'           => format,
            'hypervisor'       => hypervisor,
            'name'             => name,
            'ostypeid'         => os_type_id,
            'url'              => url,
            'zoneid'           => zone_id,
            'account'          => account,
            'bits'             => bits,
            'checksum'         => checksum,
            'details'          => details,
            'domainid'         => domain_id,
            'isextractable'    => is_extractable,
            'isfeatured'       => is_featured,
            'ispublic'         => is_public,
            'passwordenabled'  => password_enabled,
            'projectid'        => project_id,
            'requireshvm'      => requires_hvm,
            'sshkeyenabled'  => ssh_key_enabled,
            'templatetag'      => template_tag
          }
          data = service.register_template(options)
          merge_attributes(data['registertemplateresponse'])
        end

        def destroy
          requires :id
          service.delete_template('id' => self.id)
          true
        end
      end # Server
    end # Cloudstack
  end # Compute
end # Fog
