require 'fog/core/collection'
require 'fog/cloudstack/models/compute/rubycon'

module Fog
  module Compute
    class Cloudstack

      class Rubycons < Fog::Collection

        model Fog::Compute::Cloudstack::Rubycon

        def all(attributes={})
          response = service.list_accounts
          data = response["listaccountsresponse"]["account"] || []
          load(data)
        end

        def get(name)
          if account = service.list_accounts('name' => name)["listaccountsresponse"]["account"].try(:first)
            new(account)
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end
      end

    end
  end
end