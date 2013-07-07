require 'fog/core/collection'
require 'fog/cloudstack/models/compute/volume'

module Fog
  module Compute
    class Cloudstack

      class Volumes < Fog::Collection

        model Fog::Compute::Cloudstack::Volume

        def all(params = {})
          data = service.list_volumes(params)["listvolumesresponse"]["volume"] || []
          @filter_attributes = attributes.except("command", "response", "sessionkey") if @filter_attributes.nil?
          load(data, @filter_attributes.nil?)
        end

        def get(volume_id)
          if volume = service.list_volumes(scoped_attributes(id: volume_id))["listvolumesresponse"]["volume"].first
            new(volume)
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end
      end

    end
  end
end
