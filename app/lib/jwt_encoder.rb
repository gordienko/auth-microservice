# frozen_string_literal: true

# Jwt Encoder
#
module JwtEncoder
  module_function

  HMAC_SECRET = Settings.secret_key_base

  def encode(payload)
    JWT.encode(payload, HMAC_SECRET)
  end

  def decode(token)
    JWT.decode(token, HMAC_SECRET).first
  end
end
