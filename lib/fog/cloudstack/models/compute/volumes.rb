require 'fog/core/collection'
require 'fog/cloudstack/models/compute/volume'

module Fog
  module Compute
    class Cloudstack

      class Volumes < Fog::Collection

        model Fog::Compute::Cloudstack::Volume

        def all(params = {})
          data = service.list_volumes(params)["listvolumesresponse"]["volume"] || []
          load(data)
        end

        def get(volume_id)
          if volume = service.list_volumes('id' => volume_id)["listvolumesresponse"]["volume"].try(:first)
            new(volume)
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end
      end

    end
  end
end
