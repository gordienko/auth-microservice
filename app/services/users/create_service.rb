# frozen_string_literal: true

module Users
  # Create User Service
  #
  class CreateService
    prepend BasicService

    option :name
    option :email
    option :password

    attr_reader :user

    def call
      @user = ::User.new(
        name: @name,
        email: @email,
        password: @password,
        password_confirmation: @password
      )

      @user.valid? ? @user.save : fail!(@user.errors)
    end
  end
end
