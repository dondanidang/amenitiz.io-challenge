require 'active_record'
require 'activerecord-import'
require 'byebug'
require 'money'
require 'money-rails'
require 'sqlite3'
require 'thor'
require_relative './database'
Dir["#{File.dirname(__FILE__)}/../app/**/*.rb"].each { require _1 }
Dir["#{File.dirname(__FILE__)}/initializers/**/*.rb"].each { require _1 }
Dir["#{File.dirname(__FILE__)}/../db/**/*.rb"].each { require _1 }
