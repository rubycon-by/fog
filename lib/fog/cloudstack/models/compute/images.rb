require 'fog/core/collection'
require 'fog/cloudstack/models/compute/image'

module Fog
  module Compute
    class Cloudstack

      class Images < Fog::Collection

        model Fog::Compute::Cloudstack::Image

        def all(params = {})
          data = service.list_templates(params)["listtemplatesresponse"]["template"] || []
          condition = @filter_attributes.nil?
          @filter_attributes = attributes.except("command", "response", "sessionkey") if @filter_attributes.nil?
          load(data, condition)
        end


        def get(image_id)
          if template = service.list_isos('id' => image_id)["listtemplatesresponse"]["template"].try(:first)
            new(template)
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end

        def register(attributes={})
          as_iso = attributes.try(:delete,'as_iso') || false
          image = new(attributes)
          as_iso ? image.register_as_iso : image.register_as_template
        end

        private

        def get_filter_options(filters, as_iso)
          key = as_iso ? 'isofilter' : 'templatefilter'
          default_filter = { key => 'self' }
          default_filter.merge(filters)
        end
      end
    end
  end
end
