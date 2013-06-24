require 'fog/core/collection'
require 'fog/cloudstack/models/compute/image'

module Fog
  module Compute
    class Cloudstack

      class Images < Fog::Collection

        model Fog::Compute::Cloudstack::Image

        def all(filters={})
          as_iso = filters.try(:delete, 'as_iso') || false
          options = get_filter_options(filters, as_iso)

          data = if as_iso
            service.list_isos(options)["listisosresponse"]["iso"] || []
          else
            service.list_templates(options)["listtemplatesresponse"]["template"] || []
          end
          load(data)
        end

        def get(image_id, filters={})
          as_iso = filters.try(:delete, 'as_iso') || false
          filter_option = get_filter_options(filters, as_iso)
          options = filter_option.merge('id' => image_id)

          if template = service.list_templates(options)["listtemplatesresponse"]["template"].try(:first)
            new(template)
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end

        def register(attributes={})
          as_iso = attributes.try(:delete, 'as_iso') || false
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
