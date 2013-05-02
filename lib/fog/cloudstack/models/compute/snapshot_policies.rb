require 'fog/core/collection'
require 'fog/cloudstack/models/compute/snapshot_policy'

module Fog
  module Compute
    class Cloudstack
      class SnapshotPolicies < Fog::Collection
        model Fog::Compute::Cloudstack::SnapshotPolicy
      end
    end
  end
end
