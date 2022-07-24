# frozen_string_literal: true

require 'pry'

RSpec.describe Auth::FetchUserService do
  subject { described_class }

  let(:session) { create(:session) }
  let(:user) { session.user }
  let(:uuid) { session.uuid }
  let(:token) { JwtEncoder.encode(uuid: uuid) }

  context 'valid parameters' do
    it 'test' do
      result = subject.call(token: token)

      expect(result.user).to eq(user)
    end
  end

  context 'invalid parameters' do
    let(:token) { '' }

    it 'assigns user' do
      result = subject.call(token: token)

      expect(result.user).to be_nil
    end
  end
end
