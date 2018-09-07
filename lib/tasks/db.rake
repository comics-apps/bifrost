namespace :db do
  desc "Create database"
  task :create do
    config = Rake::Task["db:config"].invoke[0].call
    Bifrost.connect(:postgres, config.merge(database: "postgres"))

    Bifrost.postgres.execute(
      "CREATE DATABASE #{config[:database]} ENCODING 'UTF8';"
    )
  end

  desc "Drop database"
  task :drop do
    config = Rake::Task["db:config"].invoke[0].call
    Bifrost.connect(:postgres, config.merge(database: "postgres"))

    Bifrost.postgres.execute(
      "DROP DATABASE #{config[:database]}"
    )
  end

  desc "Run migrations"
  task :migrate do
    config = Rake::Task["db:config"].invoke[0].call
    Bifrost.connect(:postgres, config)

    Sequel.extension(:migration)
    version = ENV["VERSION"] ? ENV["VERSION"].to_i : nil
    Sequel::Migrator.run(
      Bifrost.postgres, "db/migrations",
      use_transactions: true, target: version
    )
  end
end
