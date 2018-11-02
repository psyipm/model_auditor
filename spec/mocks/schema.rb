# frozen_string_literal: true

ActiveRecord::Schema.define do
  create_table 'users', force: true do |t|
    t.string :name, limit: 64
    t.integer :login_count
    t.integer :failed_attempts
    t.datetime :created_at, null: false
    t.datetime :updated_at, null: false
  end

  create_table 'sessions', force: true do |t|
    t.integer :user_id
    t.string :token
    t.datetime :created_at, null: false
    t.datetime :updated_at, null: false
  end
end
