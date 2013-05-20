require "fog/core/deprecated_connection_accessors"

module Fog
  class Collection < Array
    extend Fog::Attributes::ClassMethods
    include Fog::Attributes::InstanceMethods
    include Fog::Core::DeprecatedConnectionAccessors

    attr_reader :service
    attr_accessor :filter_attributes

    Array.public_instance_methods(false).each do |method|
      unless [:reject, :select, :slice].include?(method.to_sym)
        class_eval <<-EOS, __FILE__, __LINE__
          def #{method}(*args)
            p #{*args}
            unless @loaded
              lazy_load
            end
            super
          end
        EOS
      end
    end

    %w[reject select slice].each do |method|
      class_eval <<-EOS, __FILE__, __LINE__
        def #{method}(*args)
          p #{*args}
          unless @loaded
            lazy_load
          end
          data = super
          self.clone.clear.concat(data)
        end
      EOS
    end

    def self.model(new_model=nil)
      if new_model == nil
        @model
      else
        @model = new_model
      end
    end

    remove_method :clear
    def clear
      @loaded = true
      super
    end

    def create(attributes = {})
      object = new(attributes)
      object.save
      object
    end

    def destroy(identity)
      object = new(:identity => identity)
      object.destroy
    end

    # Creates a new Fog::Collection based around the passed service
    #
    # @param [Hash] attributes
    # @option attributes [Fog::Service] service Instance of a service
    #
    # @return [Fog::Collection]
    #
    def initialize(attributes = {})
      # p "collection initialize #{attributes}"
      @service = attributes.delete(:service)
      @loaded = false
      @filter_attributes = {}.merge(attributes)
      merge_attributes(@filter_attributes)
    end


    remove_method :inspect
    def inspect
      Thread.current[:formatador] ||= Formatador.new
      data = "#{Thread.current[:formatador].indentation}<#{self.class.name}\n"
      Thread.current[:formatador].indent do
        unless self.class.attributes.empty?
          data << "#{Thread.current[:formatador].indentation}"
          data << self.class.attributes.map {|attribute| "#{attribute}=#{send(attribute).inspect}"}.join(",\n#{Thread.current[:formatador].indentation}")
          data << "\n"
        end
        data << "#{Thread.current[:formatador].indentation}["
        unless self.empty?
          data << "\n"
          Thread.current[:formatador].indent do
            data << self.map {|member| member.inspect}.join(",\n")
            data << "\n"
          end
          data << Thread.current[:formatador].indentation
        end
        data << "]\n"
      end
      data << "#{Thread.current[:formatador].indentation}>"
      data
    end

    def load(objects)
      clear
      for object in objects
        self << new(object)
      end
      self
    end

    def model
      self.class.instance_variable_get('@model')
    end

    def new(attributes = {})
      unless attributes.is_a?(::Hash)
        raise(ArgumentError.new("Initialization parameters must be an attributes hash, got #{attributes.class} #{attributes.inspect}"))
      end
      model.new(
        {
          :collection => self,
          :service => service
        }.merge(attributes)
      )
    end

    def reload
      clear
      lazy_load
      self
    end

    def table(attributes = nil)
      Formatador.display_table(self.map {|instance| instance.attributes}, attributes)
    end

    def to_json(options = {})
      Fog::JSON.encode(self.map {|member| member.attributes})
    end

    private

    def lazy_load
      self.all @filter_attributes
    end

  end
end
