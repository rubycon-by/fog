module Fog
  module Compute
    class Cloudstack
      class Rubycon < Fog::Model
        identity  :id,                 :aliases => 'id'
        attribute :name,               :aliases => 'name'
        attribute :state,              :aliases => 'state'

      end # Rubycon
    end # Cloudstack
  end # Compute
end # Fog
