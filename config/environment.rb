
require "bundler/setup"
Bundler.require
require "sinatra/activerecord"
require "ostruct"
require "date"
require_all 'app/models'
require "json"
require 'rest-client'
require 'pry'
require "tty-prompt"

ENV["SINATRA_ENV"] ||= 'development'
ActiveRecord::Base.establish_connection(ENV["SINATRA_ENV"].to_sym)
ActiveRecord::Base.logger = nil