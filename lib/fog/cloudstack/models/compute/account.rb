module Fog
  module Compute
    class Cloudstack
      class Account < Fog::Model
        identity  :id,                 :aliases => 'id'
        attribute :name,               :aliases => 'name'
        attribute :state,              :aliases => 'state'

      end # Account
    end # Cloudstack
  end # Compute
end # Fog
