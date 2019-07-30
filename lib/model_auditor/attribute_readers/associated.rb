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
        title || name || id
      end

      protected

      def attr_name(pattern, replacement = '')
        return unless key.to_s =~ pattern

        attribute_name = key.to_s.gsub(pattern, replacement)

        attribute_name if model.respond_to?(attribute_name)
      end

      private

      def title
        associated_model.title if associated_model.respond_to?(:title)
      end

      def name
        associated_model.name if associated_model.respond_to?(:name)
      end

      def id
        associated_model.id if associated_model.respond_to?(:id)
      end

      def associated_model
        return unless method_name

        model.send(method_name)
      end

      def method_name
        attr_name(/_id$/)
      end
    end
  end
end
