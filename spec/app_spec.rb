require 'rubygems'
require 'spec'
require 'rack/test'
require 'ruby-debug'
require 'nokogiri'

require "#{File.dirname(__FILE__)}/../app.rb" # <-- your sinatra app

set :environment, :test

describe 'The app.rb App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "says SV Rails Conf" do
    get '/'
    last_response.should be_ok
    ndoc= Nokogiri::HTML(last_response.body)
    ndoc.css("h1")[0].content.should match /SV Rails Conf/
  end
end

