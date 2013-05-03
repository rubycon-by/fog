module Fog
  module Compute
    class Cloudstack
      class VpnUser < Fog::Model

        identity :id,    :aliases => 'id'
        attribute :username,    :aliases => 'username'
        attribute :account,    :aliases => 'account'
        attribute :domain_id,    :aliases => 'domainid'
        attribute :domain_name,    :aliases => 'domainname'


        def save attributes={}
          requires :username
          service.add_vpn_user({'username' => self.username}.merge!(attributes))
        end

        def destroy
          requires :username
          service.remove_vpn_user({'username' => self.username})
        end

      end  #Ip
    end # Cloudstack
  end # Compute
end # Fog
