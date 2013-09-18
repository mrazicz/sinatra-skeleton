# encoding: utf-8

require 'bundler/setup'
require 'sinatra/base'
require 'slim'
require 'sass'
require 'coffee-script'
require 'rack-flash'
require 'sinatra/asset_pipeline'

# hack for ruby < 2.0.0
__dir__ = File.dirname(__FILE__)

# !!! SET HERE YOUR APP NAME !!!
MY_APP_NAME = 'MyApp'

# do magic with app name :)
Object.const_set(MY_APP_NAME, Module.new {})
MY_APP = Kernel.const_get(MY_APP_NAME)

module MY_APP
  class App < Sinatra::Base
    enable :sessions, :logging

    # Include these files when precompiling assets
    set :assets_precompile, %w(*.js *.css *.png *.jpg *.svg *.eot *.ttf *.woff)
    # CSS minification
    set :assets_css_compressor, :sass
    # JavaScript minification
    set :assets_js_compressor, :uglifier
    # Logical path to your assets
    set :assets_prefix, 'views/assets'
    register Sinatra::AssetPipeline

    use Rack::MethodOverride
    use Rack::Flash, :accessorize => [:info, :error, :success], :sweep => true
    use Rack::Protection::AuthenticityToken
    set :root, __dir__
    set :public_folder, __dir__ + '/public'
    set :views, __dir__ + '/views'
    set :session_secret, 'SomeV3ryS3cretC0deAndYouSh0uldProbablyChangeTh1s:)'
    set :slim, :layout_engine => :slim, :layout => :'layouts/application',
      :use_html_safe => true, :pretty => App.environment == :development
    set :cookie_options, { path: '/'}

    configure :development do
      require "sinatra/reloader"
      register Sinatra::Reloader
      also_reload 'models/**/*.rb'
      also_reload 'lib/**/*.rb'
      also_reload 'helpers/**/*.rb'
      also_reload 'routes/**/*.rb'
      set :raise_errors, true
    end

  end
end

# require all necessary files - NASTY code, I know :)
['lib', 'models', 'helpers', 'routes'].each do |dir|
  Dir.glob("#{__dir__}/#{dir}/*.rb").each {|file| require_relative file.to_s }
end


