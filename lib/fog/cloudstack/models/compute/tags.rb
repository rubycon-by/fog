require 'fog/core/collection'
require 'fog/cloudstack/models/compute/tag'

module Fog
  module Compute
    class Cloudstack

      class Tags < Fog::Collection

        model Fog::Compute::Cloudstack::Tag

        def all
          data = service.list_tags["listtagsresponse"]["tags"] || []
          load(data)
        end
      
        # def get(job_id)
        #   if job = service.query_async_job_result('jobid' => job_id)["queryasyncjobresultresponse"]
        #     new(job)
        #   end
        # rescue Fog::Compute::Cloudstack::BadRequest
        #   nil
        # end
      end

    end
  end
end
