# frozen_string_literal: true

# User Routes
#
class UserRoutes < Application
  namespace '/v1' do
    post do
      user_params = validate_with!(UserParamsContract)

      result = Users::CreateService.call(
        name: user_params[:name],
        email: user_params[:email],
        password: user_params[:password]
      )

      if result.success?
        serializer = SuccessSerializer.new(result.user)

        status 201
        json serializer.serializable_hash
      else
        status 422
        error_response result.user
      end
    end
  end
end
