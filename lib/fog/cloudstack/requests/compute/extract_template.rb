module Fog
  module Compute
    class Cloudstack
      class Real

        def extract_template(options={}, mode = "HTTP_DOWNLOAD")
          options.merge!(
            'command' => 'extractTemplate',
            'mode' => mode
          )

          request(options)
        end

      end
    end
  end
end
