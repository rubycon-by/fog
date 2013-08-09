# module Fog
#   module Compute
#     class Cloudstack
#       class Real

#         # Lists user accounts.
#         #
#         # {CloudStack API Reference}[http://download.cloud.com/releases/2.2.0/api_2.2.4/global_admin/listUsers.html]
#         def login(options={})
#           options.merge!(
#             'command' => 'login'
#           )
#           request(options)
#         end

#       end
#     end
#   end
# end
