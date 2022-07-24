# frozen_string_literal: true

# Session Params Contract
#
class SessionParamsContract < Dry::Validation::Contract
  params do
    required(:email).value(:string)
    required(:password).value(:string)
  end
end
