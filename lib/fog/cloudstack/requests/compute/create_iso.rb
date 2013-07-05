module Fog
  module Compute
    class Cloudstack
      class Real

        def create_iso(options={})
          options.merge!(
            'command' => 'createIso'
          )

          request(options)
        end

      end
    end
  end
end
