module MY_APP
  module UtilsHelpers
    def example_helper
      puts "I'm example helper!"
      puts "You can find me here: '#{File.expand_path(__FILE__)}'."
    end
  end
end

MY_APP::App.helpers MY_APP::UtilsHelpers

