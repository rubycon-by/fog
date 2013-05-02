module Fog
  module Compute
    class Cloudstack
      class SnapshotPolicy < Fog::Model
        identity  :id,                         :aliases => 'id'

        attribute :intervaltype,               :aliases => 'intervaltype'
        attribute :maxsnaps,                   :aliases => 'maxsnaps'
        attribute :schedule,                   :aliases => 'schedule'
        attribute :timezone,                   :aliases => 'timezone'
        attribute :volume_id,                  :aliases => 'volumeid'

        def save
          requires :volume_id, :intervaltype, :maxsnaps, :schedule, :timezone

          options = {
            'volumeid'      => volume_id,
            'intervaltype'  => intervaltype,
            'maxsnaps'      => maxsnaps,
            'schedule'      => schedule,
            'timezone'      => timezone
          }
          data = service.create_snapshot_policy(options)
          merge_attributes(data['createsnapshotpolicyresponse'])
        end

        def destroy
          requires :id
          service.delete_snapshot_policy('id' => id)
          true
        end
      end # SnapshotPolicy
    end # Cloudstack
  end # Compute
end # Fog
