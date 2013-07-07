require 'fog/core/collection'
require 'fog/cloudstack/models/compute/event'

module Fog
  module Compute
    class Cloudstack

      class Events < Fog::Collection

        model Fog::Compute::Cloudstack::Event

        def all
          data = service.list_events["listeventsresponse"]["event"] || []
          load(data)
        end
      end

    end
  end
end
