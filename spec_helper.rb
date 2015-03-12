require 'pry'
require 'rspec'
require './safe_require'

RSpec.configure do |config|
  config.color = true
  config.formatter = 'documentation'
end 

safe_require 'robot'
safe_require 'item'
safe_require 'weapon'
safe_require 'box_of_bolts'
safe_require 'laser'
safe_require 'plasma_cannon'
safe_require 'grenade'
