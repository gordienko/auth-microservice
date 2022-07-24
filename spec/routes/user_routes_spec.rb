# frozen_string_literal: true

RSpec.describe UserRoutes, type: :routes do # rubocop: disable Metrics/BlockLength
  describe 'POST /v1' do # rubocop: disable Metrics/BlockLength
    context 'valid parameters' do
      let(:user_params) do
        {
          name: 'Alexey',
          email: 'alx@example.com',
          password: 'Pa$$W0Rd'
        }
      end

      let(:last_user) { User.last }

      it 'creates a new user' do
        expect { post '/v1', user_params }
          .to change(User, :count).from(0).to(1)

        expect(last_response.status).to eq(201)
      end

      it 'returns an user' do
        post '/v1', user_params

        expect(response_body['data']).to a_hash_including(
          'id' => last_user.id.to_s,
          'type' => 'success'
        )
      end
    end

    context 'user already exists' do
      let(:user_params) do
        {
          name: 'Alexey',
          email: 'alx@example.com',
          password: 'Pa$$W0Rd'
        }
      end

      before do
        create(:user, user_params)
      end

      it 'returns an error' do
        post '/v1', user_params

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Пользователь с таким email уже существует',
            'source' => {
              'pointer' => '/data/attributes/email'
            }
          }
        )
      end
    end

    context 'missing parameters' do
      it 'returns an error' do
        post '/v1'

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      let(:user_params) do
        {
          name: 'Alexey',
          email: 'alx@example.com',
          password: ''
        }
      end

      it 'returns an error' do
        post '/v1', user_params

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Пароль не может быть пустым',
            'source' => {
              'pointer' => '/data/attributes/password'
            }
          }
        )
      end
    end

    context 'invalid username' do
      let(:user_params) do
        {
          name: 'Invalid Username',
          email: 'alx@example.com',
          password: 'Password'
        }
      end

      it 'returns an error' do
        post '/v1', user_params

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Имя имеет неправильный формат',
            'source' => {
              'pointer' => '/data/attributes/name'
            }
          }
        )
      end
    end
  end
end
