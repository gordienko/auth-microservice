# frozen_string_literal: true

RSpec.describe Users::CreateService do # rubocop: disable Metrics/BlockLength
  subject { described_class }

  let(:user_params) do
    {
      name: 'John Doe',
      email: 'john@example.com',
      password: password
    }
  end
  let(:password) { 'Pa$$W0rD' }

  context 'valid parameters' do
    it 'creates a new user' do
      expect { subject.call(user_params) }
        .to change { User.count }.from(0).to(1)
    end

    it 'assigns user' do
      result = subject.call(user_params)

      expect(result.user).to be_kind_of(User)
    end
  end

  context 'invalid parameters' do
    let(:password) { '' }

    it 'does not create user' do
      expect { subject.call(user_params) }
        .not_to change(User, :count)
    end

    it 'assigns user' do
      result = subject.call(user_params)

      expect(result.user).to be_kind_of(User)
    end
  end
end
