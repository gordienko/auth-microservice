# frozen_string_literal: true

module Auth
  # Fetch User Service
  #
  class FetchUserService
    prepend BasicService

    option :token

    attr_reader :user

    def call
      return fail!(I18n.t(:forbidden, scope: 'services.auth.fetch_user_service')) if @token.blank? || session.blank?

      @user = session.user
    end

    private

    def session
      @session ||= Session.first(uuid: extracted_token['uuid'])
    end

    def extracted_token
      JwtEncoder.decode(token)
    rescue JWT::DecodeError
      {}
    end
  end
end
