# frozen_string_literal: true

require 'pry'

RSpec.describe Sessions::CreateService do # rubocop: disable Metrics/BlockLength
  subject { described_class }

  let(:name) { 'John' }
  let(:email) { 'john@example.com' }
  let(:password) { 'Pa$$W0rD' }

  before { create(:user, name: name, email: email, password: password) }

  context 'valid parameters' do
    let(:auth_params) do
      {
        email: email,
        password: password
      }
    end

    it 'creates a new session' do
      expect { subject.call(auth_params) }
        .to change { Session.count }.from(0).to(1)
    end

    it 'assigns session' do
      result = subject.call(auth_params)

      expect(result.session).to be_kind_of(Session)
    end
  end

  context 'invalid parameters' do
    let(:auth_params) do
      {
        email: email,
        password: ''
      }
    end

    it 'does not create session' do
      expect { subject.call(auth_params) }
        .not_to change(Session, :count)
    end

    it 'assigns session' do
      result = subject.call(auth_params)

      expect(result.session).to be_nil
    end
  end
end
