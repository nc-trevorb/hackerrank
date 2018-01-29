require 'rspec'
require 'pry'

Dir[File.expand_path("./lib/**/*.rb")].each(&method(:require))