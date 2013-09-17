module Fog
  module Compute
    class Cloudstack
      class OsType < Fog::Model
        identity  :id,              :aliases => 'id'
        attribute :os_category_id, :aliases => 'oscategoryid'
        attribute :description, :aliases => 'description'

      end 
    end # Cloudstack
  end # Compute
end # Fog
