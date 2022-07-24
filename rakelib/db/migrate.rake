# frozen_string_literal: true

namespace :db do
  desc 'Run database migrations'
  task :migrate, %i[version] => :settings do |_t, args|
    require 'sequel/core'
    Sequel.extension :migration

    Sequel.connect(Settings.db.to_hash) do |db|
      migrations = File.expand_path('../../db/migrations', __dir__)
      version = args.version.to_i if args.version
      Sequel::Migrator.run(db, migrations, target: version)

      db.extension :schema_dumper
      dump_file = File.expand_path('../../db/schema.rb', __dir__)
      File.open(dump_file, 'w') do |f|
        f.write(
          db.dump_schema_migration
        )
      end
    end
  end
end
