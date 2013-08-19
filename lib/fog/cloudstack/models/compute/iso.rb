module Fog
  module Compute
    class Cloudstack
      class Iso < Fog::Model
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
        attribute :password_enabled,   :aliases => 'passwordenabled'
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

        attr_accessor :bits, :requires_hvm, :snapshot_id, :url, :virtual_machine_id, :volume_id

        def save
          data = service.create_template(get_options_hash)
          data['createtemplateresponse']
          # merge_attributes(data['createtemplateresponse'])
        end

        def attach server_id
          data = service.attach_iso('virtualmachineid' => server_id, 'id' => id)
          data['attachisoresponse']
        end

        def detach server_id
          data = service.detach_iso('virtualmachineid' => server_id)
          data['detachisoresponse']
        end

        def copy destination_zone_id
          requires :id, :zone_id
          options = {'id' => self.id, 'destzoneid' => destination_zone_id, 'sourcezoneid' => self.zone_id}
          data = service.copy_iso(options)
          data['copytemplateresponse']
        end

        def update options
          requires :id
          data = service.update_iso({'id' => self.id}.merge!(options))
          data['updateisoresponse']
        end

        def extract url = nil
          requires :id, :zone_id
          options = { 'id' => self.id, 'zoneid' => self.zone_id }
          options.merge!({'url' => url}) if url.present?
          data = service.extract_iso options
          data['extractisoresponse']
        end

        def destroy
          requires :id
          data = service.delete_iso('id' => self.id)
          data['deleteisosresponse']
        end

        def register
          requires :display_text, :name, :url, :zone_id

          options = {
            'displaytext'      => display_text,
            'name'             => name,
            'ostypeid'         => os_type_id,
            'url'              => url,
            'zoneid'           => zone_id,
            'account'          => account,
            'checksum'         => checksum,
            'domainid'         => domain_id,
            'isextractable'    => is_extractable,
            'isfeatured'       => is_featured,
            'ispublic'         => is_public,
            'projectid'        => project_id,
          }
          data = service.register_iso(options)
          # data['registerisoresponse']
        end

        def get_options_hash
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
        end

      end # Iso
    end # Cloudstack
  end # Compute
end # Fog
