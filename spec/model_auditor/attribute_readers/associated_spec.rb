# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ModelAuditor::AttributeReaders::Associated do
  let!(:user) { User.create(name: 'test_user', login_count: 10, failed_attempts: 5) }
  let!(:session) { Session.create(user: user, token: 'some_token') }

  let(:user_title) { "User account ##{user.id}" }
  let(:subject) { described_class.new(session, :user_id) }

  it 'should read associated model :title' do
    allow(user).to receive(:title).and_return(user_title)

    expect(subject.value).to eq user_title
  end
end
