# frozen_string_literal: true

# Session Params Contract
#
class AuthParamsContract < Dry::Validation::Contract
  params do
    required(:token).value(:string)
  end
end
