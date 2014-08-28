# encoding: utf-8

# basic gems -------------------------------------------------------------------
require 'rubygems'
require 'bundler'

# require bundler gems ---------------------------------------------------------
Bundler.require

# additional gems --------------------------------------------------------------
require 'set'
require 'hashie'
require 'sinatra/asset_pipeline'

# sinatra ----------------------------------------------------------------------
require 'sinatra/base'

# app settings -----------------------------------------------------------------
module MyApp
  class App < Sinatra::Base
    set :assets_prefix, %w(assets)
    set :assets_precompile, %w(*.js *.css *.sass)
    register Sinatra::AssetPipeline

    set :root, File.absolute_path(File.dirname(__FILE__))
  end
end

# require models, routes etc. --------------------------------------------------
['models', 'routes'].each do |dir|
  Dir.glob("#{File.dirname(__FILE__)}/#{dir}/**/*.rb").each do |file|
    require file
  end
end

# app main ---------------------------------------------------------------------
module MyApp
  class App < Sinatra::Base
    get '/' do
      slim :index
    end
  end
end
