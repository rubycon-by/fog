module Fog
  module Compute
    class Cloudstack
      class VpnUser < Fog::Model

        identity :id,    :aliases => 'id'
        attribute :username,    :aliases => 'username'
        attribute :password,    :aliases => 'password'
        attribute :account,    :aliases => 'account'
        attribute :domain_id,    :aliases => 'domainid'
        attribute :domain_name,    :aliases => 'domainname'


        def save
          requires :username, :password
          options = {'username' => username, 'password' => password}
          data = service.add_vpn_user(options)
          data['addvpnuserresponse']
        end

        def destroy
          requires :username
          puts username
          data = service.remove_vpn_user({'username' => username})
          data['removevpnuserresponse']
        end

      end  #Ip
    end # Cloudstack
  end # Compute
end # Fog
