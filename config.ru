# frozen_string_literal: true

require_relative 'config/environmant'

map '/sign_up' do
  run UserRoutes
end

map '/sign_in' do
  run SessionRoutes
end

map '/auth' do
  run AuthRoutes
end
