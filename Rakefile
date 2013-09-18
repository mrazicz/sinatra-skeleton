require 'sinatra/asset_pipeline/task.rb'
require "./app"
Sinatra::AssetPipeline::Task.define! MY_APP::App

desc "launch console in #{MY_APP_NAME} context"
task :console do
  require 'pry'
  require 'pry-debugger'

  Pry.start MY_APP
end
task :c => :console

