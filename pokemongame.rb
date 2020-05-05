require "tty-prompt"
require_relative 'config/environment.rb'
require_all 'app/models'

prompt = TTY::Prompt.new


prompt.say("Welcome to Pokemon World!!!")
name = prompt.ask('What is your name?', default: ENV['USER'])