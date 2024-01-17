require_relative './loader'

class Application
  def self.start
    app = Application.new

    app.sync_db_structure
  end

  def sync_db_structure
    ActiveRecord::Migration.verbose = false

    CreateMigrations.migrate(:up) unless ActiveRecord::Base.connection.table_exists?(:migrations);
    Dir["#{File.dirname(__FILE__)}/../db/migrations/**/*.rb"].each do |file_path|
      file_name = File.basename(file_path, '.rb')
      table_name = file_name.split('_').last.pluralize

      next if table_name == 'migrations'

      migration_name = file_name.split('_').first

      next if Migration.exists?(name: migration_name)

      klass_name = file_name.split('_').drop(1).join('_').camelize
      klass = Object.const_get(klass_name)

      klass.migrate(:up)
      Migration.create!(name: migration_name)
    end
  end
end
