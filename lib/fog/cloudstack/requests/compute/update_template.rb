module Fog
  module Compute
    class Cloudstack
      class Real

        def update_iso(options={})
          options.merge!(
            'command' => 'updateTemplate'
          )

          request(options)
        end

      end
    end
  end
end
