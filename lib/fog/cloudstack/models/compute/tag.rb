module Fog
  module Compute
    class Cloudstack
      class Tag < Fog::Model
        identity :id,    :aliases => 'id'
        attribute :account,    :aliases => 'account'
        attribute :customer,    :aliases => 'customer'
        attribute :domain_id,    :aliases => 'domainid'
        attribute :domain,    :aliases => 'domain'
        attribute :key,    :aliases => 'key'
        attribute :project,    :aliases => 'project'
        attribute :project_id,    :aliases => 'projectid'
        attribute :resource_id,    :aliases => 'resourceid'
        attribute :resource_type,    :aliases => 'resourcetype'
        attribute :value,    :aliases => 'value'

        # def save hash
        #   # requires :name, :disk_offering_id, :zone_id

        #   options = {
        #     'resourceids'  => hash[:ids],
        #     'name'         => name,
        #     'resourcetype' => disk_offering_id,
        #     'tags'         => zone_id,
        #     'customer'     => snapshot_id,
        #   }
        #   data = service.create_volume(options)
        #   data['createvolumeresponse']
        # end

        def destroy
          
        end

      end
    end
  end
end