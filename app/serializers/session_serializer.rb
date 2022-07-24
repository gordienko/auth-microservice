# frozen_string_literal: true

# Session Serializer
#
class SessionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :token

  attribute :token do |object|
    JwtEncoder.encode(uuid: object.uuid)
  end
end
