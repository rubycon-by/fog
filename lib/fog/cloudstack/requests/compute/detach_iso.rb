module Fog
  module Compute
    class Cloudstack
      class Real

        def detach_iso(options={})
          options.merge!(
            'command' => 'detachIso',
          )

          request(options)
        end

      end
    end
  end
end
