require_relative '../config/application'
Dir["#{File.dirname(__FILE__)}/../spec/**/*.rb"].each do |file_path|
  next if file_path.end_with?('spec/spec_helper.rb')

  require_relative file_path
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: '../test.db'
    )

    Application.new.drop_db_structure
    Application.new.sync_db_structure

    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
