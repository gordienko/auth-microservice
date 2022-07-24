# frozen_string_literal: true

# User model
#
class User < Sequel::Model
  plugin :secure_password, include_validations: false
  plugin :association_dependencies

  NAME_FORMAT = /\A\w+\z/.freeze

  one_to_many :sessions
  add_association_dependencies sessions: :delete

  def validate
    super
    validates_presence :name, message: I18n.t(:blank, scope: 'model.errors.user.name')
    validates_format(NAME_FORMAT, :name, message: I18n.t(:format, scope: 'model.errors.user.name'))
    validates_presence :email, message: I18n.t(:blank, scope: 'model.errors.user.email')
    validates_presence :password, message: I18n.t(:blank, scope: 'model.errors.user.password') if new?
    validates_unique :email, message: I18n.t(:no_unique, scope: 'model.errors.user.email')
  end
end
