module Fog
  module Compute
    class Cloudstack
      class Tag < Fog::Model
        identity :id,    :aliases => 'id'
        attribute :account,    :aliases => 'account'
        attribute :customer,    :aliases => 'customer'
        attribute :domain_id,    :aliases => 'domainid'
        attribute :domain,    :aliases => 'domain'
        attribute :key,    :aliases => 'key'
        attribute :project,    :aliases => 'project'
        attribute :project_id,    :aliases => 'projectid'
        attribute :resource_id,    :aliases => 'resourceid'
        attribute :resource_type,    :aliases => 'resourcetype'
        attribute :value,    :aliases => 'value'

      end
    end
  end
end