module Fog
  module Compute
    class Cloudstack
      class ListAccount < Fog::Model
        identity  :id,    :aliases => 'id'
        attribute :name,  :aliases => 'name'
      end  #Account
    end # Cloudstack
  end # Compute
end # Fog
