# frozen_string_literal: true

require 'sequel/model'

class User < Sequel::Model
  plugin :secure_password
  plugin :uuid
end

Sequel.seed(:development) do
  def run
    [
      ['Bob', 'bob@example.com', 'givemeatoken'],
      ['Alexey', 'alx@example.com', 'Pa$$W0Rd']
    ].each do |name, email, password|
      User.create(
        name: name,
        email: email,
        password: password,
        password_confirmation: password,
        created_at: Time.now,
        updated_at: Time.now
      )
    end
  end
end
