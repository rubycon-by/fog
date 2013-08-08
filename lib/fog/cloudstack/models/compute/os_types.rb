require 'fog/core/collection'
require 'fog/cloudstack/models/compute/os_type'

module Fog
  module Compute
    class Cloudstack

      class OsTypes < Fog::Collection

        model Fog::Compute::Cloudstack::OsType

        def all attributes={}
          data = service.list_os_types(attributes)['listostypesresponse']['ostype'] || []
          condition = @filter_attributes.nil?
          @filter_attributes = attributes.except("command", "response", "sessionkey") if @filter_attributes.nil?
          load(data, condition)
        end

        def get(type_id)
          if type = service.list_os_types('id' => type_id)["listostypesresponse"]["ostype"].try(:first)
            new(type)
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end
      end

    end
  end
end
