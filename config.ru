require 'bundler'
Bundler.setup :default
require 'sinatra/base'
require './app'

run MY_APP::App
