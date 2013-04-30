module Fog
  module Compute
    class Cloudstack
      class Real

        def extract_iso(id, mode = "HTTP_DOWNLOAD")
          options.merge!(
            'id' => id,
            'command' => 'exctractIso',
            'mode' => mode
          )

          request(options)
        end

      end
    end
  end
end
