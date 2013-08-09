module Fog
  module Compute
    class Cloudstack
      class Real

        def attach_iso(options={})
          options.merge!(
            'command' => 'attachIso',
          )

          request(options)
        end

      end
    end
  end
end
