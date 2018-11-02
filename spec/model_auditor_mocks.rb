# frozen_string_literal: true

require 'active_record'
require 'mocks/user'
require 'mocks/session'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Schema.verbose = false
load 'mocks/schema.rb'
