require 'fog/core/collection'
require 'fog/cloudstack/models/compute/account'

module Fog
  module Compute
    class Cloudstack

      class Accounts < Fog::Collection

        model Fog::Compute::Cloudstack::Account

        def all
          response = service.list_accounts
          data = response["listaccountsresponse"]["account"] || []
          load(data)
        end

        def get_by_name(name)
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