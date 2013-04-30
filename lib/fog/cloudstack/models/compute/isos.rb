require 'fog/core/collection'
require 'fog/cloudstack/models/compute/iso'

module Fog
  module Compute
    class Cloudstack

      class Isos < Fog::Collection

        model Fog::Compute::Cloudstack::Iso

        def all(attributes={})
          response = service.list_isos
          data = response["listisosresponse"]["iso"] || []
          load(data)
        end

        def get(iso_id)
          if iso = service.list_isos('id' => iso_id)["listisosresponse"]["iso"].first
            new(iso)
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end
      end

    end
  end
end