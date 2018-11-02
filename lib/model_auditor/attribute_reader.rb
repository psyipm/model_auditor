# frozen_string_literal: true

module ModelAuditor
  class AttributeReader
    attr_reader :model, :key

    def initialize(model, key)
      @model = model
      @key = key
    end

    def value
      associated_attr_value || array_attr_value || model.send(key)
    end

    private

    def associated_attr_value
      ModelAuditor::AttributeReaders::Associated.new(model, key).value
    end

    def array_attr_value
      ModelAuditor::AttributeReaders::ArrayField.new(model, key).value
    end
  end
end
