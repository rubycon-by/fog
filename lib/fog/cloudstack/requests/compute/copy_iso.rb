module Fog
  module Compute
    class Cloudstack
      class Real

        def copy_iso(options={})
          options.merge!(
            'command' => 'copyIso',
          )

          request(options)
        end

      end
    end
  end
end
