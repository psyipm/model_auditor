# frozen_string_literal: true

module ModelAuditor
  class Changes
    TRUE_ARRAY = [true, 1, '1', 't', 'T', 'true', 'TRUE'].freeze
    IGNORED_ATTRIBUTES = [:created_at, :updated_at].freeze

    def initialize(model, changes = nil, options = {})
      @model = model
      @changes = changes || @model.previous_changes
      @options = options
    end

    def filter(filtered = nil)
      filtered ||= IGNORED_ATTRIBUTES

      @changes = @changes.reject do |key, _value|
        Array(filtered).include?(key.to_sym)
      end

      self
    end

    def audit
      return unless changed?

      changes = @changes.keys.inject({}) do |hash, key|
        hash.merge!(human_name(key) => human_value(key))
      end

      changes.presence
    end

    private

    def changed?
      return true if force_changed?

      @model.created_at != @model.updated_at && @model.persisted? && !@model.destroyed?
    end

    def force_changed?
      TRUE_ARRAY.include?(@options[:changed])
    end

    def human_name(key)
      @model.class.human_attribute_name(key)
    end

    def human_value(key)
      value = ModelAuditor::AttributeReader.new(@model, key).value
      return array_diff(key) if value.is_a? Array

      ModelAuditor.normalize_value(value)
    end

    def array_diff(key)
      Normalizers::ArrayDiff.new(@changes, key).normalize
    end
  end
end
