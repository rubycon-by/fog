module Fog
  module Compute
    class Cloudstack
      class Event < Fog::Model
        COMPLETED = %w(Started Scheduled)
        identity  :id,               :aliases => 'id'
        attribute :username,         :aliases => 'username'
        attribute :type,             :aliases => 'type'
        attribute :level,            :aliases => 'type'
        attribute :description,      :aliases => 'description'
        attribute :account,          :aliases => 'account'
        attribute :domain_id,        :aliases => 'domainid'
        attribute :domain,           :aliases => 'domain'
        attribute :state,            :aliases => 'state'
        attribute :parent_id,        :aliases => 'parentid'

        attribute :created_at,      :aliases => 'created',       :type => :time


        def completed?
          COMPLETED.include?(state) ? true : service.events.get(parent_id).present?
        end

      end
    end
  end
end
