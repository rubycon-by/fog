module Fog
  module Compute
    class Cloudstack
      class Real

        def delete_iso(options={})
          options.merge!(
            'command' => 'deleteIso'
          )

          request(options)
        end

      end
    end
  end
end
