# frozen_string_literal: true

# User model
#
class User < Sequel::Model
  plugin :secure_password
  plugin :uuid

  def validate
    super
    validates_presence :name, message: I18n.t(:blank, scope: 'model.errors.user.name')
    validates_presence :email, message: I18n.t(:blank, scope: 'model.errors.user.email')
    validates_presence :password, message: I18n.t(:blank, scope: 'model.errors.user.password')
    validates_unique :email
  end

  one_to_many :sessions
end
