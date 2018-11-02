# frozen_string_literal: true

require 'model_auditor/version'

module ModelAuditor
  autoload :AttributeReader, 'model_auditor/attribute_reader'
  autoload :Changes, 'model_auditor/changes'

  module AttributeReaders
    autoload :Associated, 'model_auditor/attribute_readers/associated'
    autoload :ArrayField, 'model_auditor/attribute_readers/array_field'
    autoload :String, 'model_auditor/attribute_readers/string'
  end

  module Normalizers
    autoload :ArrayDiff, 'model_auditor/normalizers/array_diff'
    autoload :String, 'model_auditor/normalizers/string'
  end

  def self.normalize_value(value)
    case value
    when Date then value.strftime('%d.%m.%Y')
    when DateTime, Time then value.strftime('%d.%m.%Y %H:%M')
    when String then Normalizers::String.new(value).normalize
    when BigDecimal then value.to_f
    when Hash, Array then value.inspect.gsub(/[\"\r\n\t]/, '')
    else value
    end
  end
end
