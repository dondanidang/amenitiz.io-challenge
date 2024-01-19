require_relative '../config/application'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: '../test.db'
    )

    Application.new.sync_db_structure

    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.after(:suite) do
    Application.new.drop_db_structure
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
