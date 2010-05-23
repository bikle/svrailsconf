#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'haml'

# In your main application file
configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

get '/' do
  haml :index
end


# This one shows how you can use refer to
# variables in your Haml views.
# This method uses member variables.
get '/hello/:name' do|name|
  @name = name
  haml :hello
end

# This method shows you how to inject
# local variables
get '/goodbye/:name' do|name|
  haml :goodbye, :locals => { :name => name }
end

get '/favicon.ico' do
end

get '/:a_haml' do|a_haml|
  haml a_haml.to_sym
end
