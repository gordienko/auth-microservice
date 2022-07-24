# frozen_string_literal: true

# Session Routes
#
class SessionRoutes < Application
  namespace '/v1' do
    post do
      session_params = validate_with!(SessionParamsContract)
      result = Sessions::CreateService.call(email: session_params[:email], password: session_params[:password])

      if result.success?
        serializer = SessionSerializer.new(result.session)

        status 201
        json serializer.serializable_hash
      else
        status 422
        error_response result.session || result.errors
      end
    end
  end
end
