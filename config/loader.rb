require 'active_record'
require 'money'
require 'money-rails'
require 'sqlite3'
require 'thor'
require_relative './database'
Dir["#{File.dirname(__FILE__)}/../app/**/*.rb"].each { require _1 }
Dir["#{File.dirname(__FILE__)}/initializers/**/*.rb"].each { require _1 }
Dir["#{File.dirname(__FILE__)}/../db/migrations/**/*.rb"].each { require _1 }
