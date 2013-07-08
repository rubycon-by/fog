require 'fog/core/collection'
require 'fog/cloudstack/models/compute/event'

module Fog
  module Compute
    class Cloudstack

      class Events < Fog::Collection

        model Fog::Compute::Cloudstack::Event

        def all(params = {})
          data = service.list_events(params)["listeventsresponse"]["event"] || []
          condition = @filter_attributes.nil?
          @filter_attributes = attributes.except("command", "response", "sessionkey") if @filter_attributes.nil?
          load(data, condition)
        end

        def get(event_id)
          if event = service.list_events('id' => event_id)["listeventsresponse"]["event"].try(:first)
            new(event)
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end

      end

    end
  end
end
