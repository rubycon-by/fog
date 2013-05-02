module Fog
  module Compute
    class Cloudstack
      class Real

        def copy_iso(options={})
          options.merge!(
            'command' => 'copyTemplate',
          )

          request(options)
        end

      end
    end
  end
end
