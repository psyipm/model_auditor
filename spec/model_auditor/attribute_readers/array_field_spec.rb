# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ModelAuditor::AttributeReaders::ArrayField do
  let!(:user) { User.create(name: 'test_user', login_count: 10, failed_attempts: 5) }
  let!(:session) { Session.create(user: user, token: 'some_token') }

  let(:session_ids) { [session.id] }
  let(:session_title) { 'Session' }

  let(:subject) { described_class.new(user, :session_ids) }

  it 'should read attributes, ending with `_ids`' do
    allow(user).to receive(:session_ids).and_return(session_ids)
    allow_any_instance_of(Session).to receive(:title).and_return(session_title)

    expect(subject.value).to eq session_title
  end

  it 'should read attributes, ending with `s_ids`' do
    allow(user).to receive(:sessions_ids).and_return(session_ids)
    allow_any_instance_of(Session).to receive(:title).and_return(session_title)

    expect(subject.value).to eq session_title
  end
end
