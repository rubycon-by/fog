module Fog
  module Compute
    class Cloudstack
      class Real
        def update_iso(options = {})
          options.merge!(
            'command' => 'updateIso'
          )
          request(options)
        end
      end
    end
  end
end