# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ModelAuditor::AttributeReader do
  let!(:user) { User.create(name: 'test_user', login_count: 10, failed_attempts: 5) }
  let!(:session) { Session.create(user: user, token: 'some_token') }

  it 'should read model attribute' do
    subject = described_class.new(user, :name)

    expect(subject.value).to eq 'test_user'
  end

  it 'should read associated attribute' do
    subject = described_class.new(session, :user_id)
    allow(user).to receive(:title).and_return('user_title')

    expect(subject.value).to_not be_nil
  end
end
