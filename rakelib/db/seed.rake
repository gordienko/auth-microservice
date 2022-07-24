# frozen_string_literal: true

namespace :db do
  desc 'Run database seed'
  task :seed, %i[version] => :settings do |_t, _args|
    require 'sequel/core'
    require 'sequel/extensions/seed'

    Sequel::Seed.setup :development
    Sequel.extension :seed

    Sequel.connect(Settings.db.to_hash) do |db|
      seeds = File.expand_path('../../db/seeds', __dir__)
      Sequel::Seeder.apply(db, seeds)
    end
  end
end
