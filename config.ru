# encoding: utf-8

require 'bundler'
Bundler.setup :default
require 'sinatra/base'
require './app.rb'

log = File.new("#{File.dirname(__FILE__)}/log/std.log", 'a')
# Do not reopen stdout for passenger!!
$stdout.reopen(log) unless defined?(PhusionPassenger)
$stderr.reopen(log)

STDOUT.sync = true
STDERR.sync = true

run ContactSyncer::App
