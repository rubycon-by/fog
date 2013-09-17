require 'fog/core/collection'
require 'fog/cloudstack/models/compute/vpn_user'

module Fog
  module Compute
    class Cloudstack

      class Accounts < Fog::Collection

        model Fog::Compute::Cloudstack::Account

        def all(attributes={})
          response = service.list_accounts attributes
          data = response["listaccountsresponse"]["account"] || []
          load(data)
        end

        def get(name)
          if data = service.list_accounts('name' => name)["listaccountsresponse"]["account"].try(:first)
            new(data)
          end
        rescue Fog::Compute::Cloudstack::BadRequest
          nil
        end
      end

    end
  end
end