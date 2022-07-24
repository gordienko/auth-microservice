# frozen_string_literal: true

# User Serializer
#
class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name,
             :email
end
