# frozen_string_literal: true

module ModelAuditor
  module AttributeReaders
    class Associated
      attr_reader :model, :key

      def initialize(model, key)
        @model = model
        @key = key
      end

      def value
        return unless method_name

        model.send(method_name)&.title
      end

      protected

      def attr_name(pattern, replacement = '')
        return unless key.to_s =~ pattern
        attribute_name = key.to_s.gsub(pattern, replacement)

        attribute_name if model.respond_to?(attribute_name)
      end

      private

      def method_name
        attr_name(/_id$/)
      end
    end
  end
end
