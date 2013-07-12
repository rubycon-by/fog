module Fog
  module Compute
    class Cloudstack
      class OsCategory < Fog::Model
        identity  :id,              :aliases => 'id'
        attribute :name, :aliases => 'name'

      end 
    end # Cloudstack
  end # Compute
end # Fog
