require 'fog/core/collection'
require 'fog/cloudstack/models/compute/os_category'

module Fog
  module Compute
    class Cloudstack

      class OsCategories < Fog::Collection

        model Fog::Compute::Cloudstack::OsCategory

        def all
          data = service.list_os_categories['listoscategoriesresponse']['oscategory'] || []
          condition = @filter_attributes.nil?
          @filter_attributes = attributes.except("command", "response", "sessionkey") if @filter_attributes.nil?
          load(data, condition)
        end

        def get(category_id)
          p category_id
          if category = service.list_os_types('id' => category_id)["listoscategoriesresponse"]["oscategory"].try(:first)
            new(category)
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end
      end

    end
  end
end
