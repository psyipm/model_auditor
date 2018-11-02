# frozen_string_literal: true

module ModelAuditor
  module AttributeReaders
    class ArrayField < Associated
      def value
        return unless method_name

        values = model.send(method_name).map { |i| i.try(:title) }
        values.join(', ') if values.try(:all?)
      end

      private

      def method_name
        attr_name(/[s]?_ids$/, 's')
      end
    end
  end
end
