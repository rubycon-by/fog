module Fog
  module Compute
    class Cloudstack
      class Real

        # Registers an existing template into the cloud.
        #
        # {CloudStack API Reference}[http://cloudstack.apache.org/docs/api/apidocs-4.0.0/user/registerIso.html]
        def register_iso(options={})
          options.merge!(
              'command' => 'registerIso'
          )

          request(options)
        end

      end # Real
    end # Cloudstack
  end # Compute
end #Fog
