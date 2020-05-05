
require "bundler/setup"
Bundler.require
require "sinatra/activerecord"
require "ostruct"
require "date"
require_all 'app/models'
require "json"
require 'rest-client'
require 'pry'
<<<<<<< HEAD
require 'rmagick'
require 'catpix'
require "down"

=======
require "tty-prompt"
>>>>>>> 0522be6a0b68daafa306ae62b607bd9c4e6aa8bc

ENV["SINATRA_ENV"] ||= 'development'
ActiveRecord::Base.establish_connection(ENV["SINATRA_ENV"].to_sym)
ActiveRecord::Base.logger = nil