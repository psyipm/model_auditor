# frozen_string_literal: true

module ModelAuditor
  module Normalizers
    class ArrayDiff
      attr_reader :changes, :key

      def initialize(changes, key)
        @changes = changes
        @key = key
      end

      def normalize
        diff.map do |title, value|
          humanize(title, value)
        end.join(', ')
      end

      private

      def diff
        { 'Inserted' => inserted, 'Removed' => removed }.reject { |_key, value| value.empty? }
      end

      def inserted
        changes[key].last - changes[key].first
      end

      def removed
        changes[key].first - changes[key].last
      end

      def humanize(title, value)
        [title, ModelAuditor.normalize_value(value)].join(': ')
      end
    end
  end
end
