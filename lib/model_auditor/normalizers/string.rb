# frozen_string_literal: true

module ModelAuditor
  module Normalizers
    class String
      attr_reader :value, :options

      DEFAULTS = {
        limit: 97
      }.freeze

      def initialize(value, options = {})
        @value = value
        @options = DEFAULTS.merge options
      end

      def normalize
        return value unless valid?

        value.truncate(limit)
      end

      def valid?
        value.present? && value.respond_to?(:truncate)
      end

      private

      def limit
        options[:limit]
      end
    end
  end
end
