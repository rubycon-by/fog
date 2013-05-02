module Fog
  module Compute
    class Cloudstack
      class Real

        def copy_template(options={})
          options.merge!(
            'command' => 'copyTemplate',
          )

          request(options)
        end

      end
    end
  end
end
