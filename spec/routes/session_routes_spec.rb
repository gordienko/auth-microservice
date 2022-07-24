# frozen_string_literal: true

RSpec.describe SessionRoutes, type: :routes do # rubocop: disable Metrics/BlockLength
  describe 'POST /v1' do # rubocop: disable Metrics/BlockLength
    let(:name) { 'Alexey' }
    let(:email) { 'alx@example.com' }
    let(:password) { 'Pa$$W0Rd' }

    before { create(:user, name: name, email: email, password: password) }

    let(:last_user) { User.last }
    let(:last_session) { last_user.sessions.last }

    let(:auth_params) do
      {
        email: email,
        password: password
      }
    end

    context 'valid parameters' do
      it 'creates a new sessions' do
        expect { post '/v1', auth_params }
          .to change(Session, :count).from(0).to(1)

        expect(last_response.status).to eq(201)
      end

      it 'returns an session' do
        post '/v1', auth_params

        expect(response_body['data']).to a_hash_including(
          'id' => last_session.id.to_s,
          'type' => 'session'
        )
      end
    end

    context 'invalid password' do
      let(:auth_params) do
        {
          email: email,
          password: 'InvalidPassword'
        }
      end

      it 'returns an error' do
        post '/v1', auth_params

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Сессия не может быть создана'
          }
        )
      end
    end

    context 'unknown email' do
      let(:auth_params) do
        {
          email: 'unk@example.com',
          password: password
        }
      end

      it 'returns an error' do
        post '/v1', auth_params

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Сессия не может быть создана'
          }
        )
      end
    end
  end
end
