# frozen_string_literal: true

# User Session model
#
class Session < Sequel::Model
  many_to_one :user
  plugin :uuid
end
