# frozen_string_literal: true

# Auth Routes
#
class AuthRoutes < Application
  namespace '/v1' do
    post do
      auth_params = validate_with!(AuthParamsContract)

      result = Auth::FetchUserService.call(token: auth_params[:token])

      if result.success?
        serializer = UserSerializer.new(result.user)

        status 201
        json serializer.serializable_hash
      else
        status 422
        error_response result.user || result.errors
      end
    end
  end
end
