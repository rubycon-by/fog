module Fog
  module Compute
    class Cloudstack
      class Real

        def enable_static_nat(options={})
          options.merge!(
            'command' => 'enableStaticNat'
          )

          request(options)
        end

      end
    end
  end
end
