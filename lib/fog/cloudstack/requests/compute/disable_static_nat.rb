module Fog
  module Compute
    class Cloudstack
      class Real

        def disable_static_nat(options={})
          options.merge!(
            'command' => 'disableStaticNat'
          )

          request(options)
        end

      end
    end
  end
end