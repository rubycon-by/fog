require 'fog/core/collection'
require 'fog/cloudstack/models/compute/snapshot_policy'

module Fog
  module Compute
    class Cloudstack
      class SnapshotPolicies < Fog::Collection
        model Fog::Compute::Cloudstack::SnapshotPolicy

        def all(volume_id,params={})
          p params
          data = service.list_snapshot_policies({'volumeid' => volume_id}.merge(params))["listsnapshotpoliciesresponse"]["snapshotpolicy"] || []
          condition = @filter_attributes.nil?
          @filter_attributes = attributes.except("command", "response", "sessionkey") if @filter_attributes.nil?
          load(data, condition)
        end

        def get(snapshot_id)
          snapshot = service.list_snapshot_policies('id' => snapshot_id)["listsnapshotpoliciesresponse"]["snapshotpolicy"].try(:first)
          new(snapshot) if snapshot
        end

      end
    end
  end
end
