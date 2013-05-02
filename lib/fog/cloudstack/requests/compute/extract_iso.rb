module Fog
  module Compute
    class Cloudstack
      class Real

        def extract_iso(options={}, mode = "HTTP_DOWNLOAD")
          options.merge!(
            'command' => 'extractIso',
            'mode' => mode
          )

          request(options)
        end

      end
    end
  end
end
