require 'sinatra/base'
require 'sinatra/namespace'
require 'sinatra/json'
require 'rack-flash'
require 'httparty'
require 'hirb'
require 'slim'
require 'chartkick'
require 'active_support'
require 'active_support/core_ext'
require 'stylemooncat'
require 'joyceshop'
require 'queenshop'
# Ensure app.rb gets loaded before all routes
require File.expand_path('../../app', __FILE__)

# Require routes.rb
require File.expand_path('../routes', __FILE__)
