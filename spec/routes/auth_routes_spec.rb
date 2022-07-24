# frozen_string_literal: true

RSpec.describe AuthRoutes, type: :routes do # rubocop: disable Metrics/BlockLength
  describe 'POST /v1' do  # rubocop: disable Metrics/BlockLength
    let(:session) { create(:session) }
    let(:user) { session.user }
    let(:token) { JwtEncoder.encode(uuid: session.uuid) }
    let(:auth_params) { { token: token } }

    context 'valid parameters' do
      it 'returns an user' do
        post '/v1', auth_params

        expect(last_response.status).to eq(201)
        expect(response_body['data']).to a_hash_including(
          'id' => user.id.to_s,
          'type' => 'user'
        )
      end
    end

    context 'invalid token' do
      let(:token) { 'invalid-token' }
      it 'returns an user' do
        post '/v1', auth_params

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Доступ к ресурсу ограничен'
          }
        )
      end
    end
  end
end
