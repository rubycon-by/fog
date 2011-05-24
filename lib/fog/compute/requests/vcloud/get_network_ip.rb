#
# AFAICT this is basically undocumented ATM - 6/18/2010 - freeformz
#

module Fog
  module Vcloud
    class Compute

      class Real
        basic_request :get_network_ip
      end

      class Mock

        def get_network_ip(network_ip_uri)
          if network_ip = mock_data.network_ip_from_href(network_ip_uri)
            builder = Builder::XmlMarkup.new
            xml = network_ip_response(builder, network_ip, xmlns)

            mock_it 200, xml, { 'Content-Type' => 'application/vnd.vmware.vcloud.ip+xml' }
          else
            mock_error 200, "401 Unauthorized"
          end
        end

        def network_ip_response(builder, network_ip, xmlns = {})
          builder.IpAddress(xmlns) do
            builder.Id network_ip.object_id
            builder.Href network_ip.href
            builder.Name network_ip.name

            builder.Status network_ip.status
            if network_ip.used_by
              builder.Server network_ip.used_by.name
            end

          end
        end
      end
    end
  end
end
