require 'fog/core/collection'
require 'fog/cloudstack/models/compute/snapshot'

module Fog
  module Compute
    class Cloudstack

      class Snapshots < Fog::Collection

        model Fog::Compute::Cloudstack::Snapshot

        def all(params={})
          data = service.list_snapshots(params)["listsnapshotsresponse"]["snapshot"] || []
          load(data)
        end

        def get(snapshot_id)
          snapshot = service.list_snapshots('id' => snapshot_id)["listsnapshotsresponse"]["snapshot"].try(:first)
          new(snapshot) if snapshot
        end
      end

    end
  end
end
