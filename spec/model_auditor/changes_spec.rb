# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ModelAuditor::Changes do
  let(:model) { User.create(name: 'test_user', login_count: 10, failed_attempts: 5) }
  let(:subject) { described_class.new(model) }

  it 'should return nil if model just created' do
    expect(subject.audit).to be_nil
  end

  it 'should return nil when model deleted' do
    model.destroy

    expect(subject.audit).to be_nil
  end

  it 'should return human readable changed attributes' do
    attrs = { name: 'John Doe', login_count: 11 }
    model.update(attrs)

    changes = subject.audit
    expect(changes['Name']).to eq 'John Doe'
    expect(changes['Login count']).to eq 11
    expect(changes['Updated at']).to_not be_nil
  end

  it 'should filter attributes based on passed arguments' do
    attrs = { name: 'John Doe', login_count: 11 }
    model.update(attrs)

    changes = subject.filter.audit
    expect(changes.keys).to contain_exactly('Name', 'Login count')

    changes = subject.filter(:login_count).audit
    expect(changes.keys).to contain_exactly('Name')
  end
end
