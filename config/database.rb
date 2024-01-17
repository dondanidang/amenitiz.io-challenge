ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: '../storage.db'
)

class Migration < ActiveRecord::Base; end
