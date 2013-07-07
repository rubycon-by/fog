require 'fog/core/collection'
require 'fog/cloudstack/models/compute/event'

module Fog
  module Compute
    class Cloudstack

      class Events < Fog::Collection

        model Fog::Compute::Cloudstack::Event

        def all
          data = service.list_events["listeventsresponse"]["event"] || []
          @filter_attributes = attributes.except("command", "response", "sessionkey") if @filter_attributes.nil?
          load(data, @filter_attributes.nil?)
        end
      end

    end
  end
end
