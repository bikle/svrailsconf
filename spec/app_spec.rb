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

  it "The homepage has SV Rails Conf" do
    # This works in Cucumber step_definitions files but not here:
    # visit "/"

    # This works in both Cucumber and RSpec:
    @rspns= get "/"
    @ndoc= Nokogiri::HTML(@rspns.body)

    @ndoc.css("div#header h1")[0].content.should match /SV Rails Conf/
    @ndoc.xpath("//body/table/tr/td/div[@id='header']/h1")[0].content.should match /SV Rails Conf/
  end

  it "The homepage has the png: svtrain.png" do
    @rspns= get "/"
    @ndoc= Nokogiri::HTML(@rspns.body)
    @ndoc.xpath("//img[@id='svtrain']/@src")[0].value.should== "/images/svtrain.png"
  end

  it "The homepage has links on LHS: Home Program Venue Speakers Registration " do
    @rspns= get "/"
    @ndoc= Nokogiri::HTML(@rspns.body)
    links_in_rspec="Home Program Venue Speakers Registration".split
    lhs_links_from_page= @ndoc.css("table tr#tr_two td#td_lhs a").map{ |ae| ae.content}
    lhs_links_from_page.sort.should== links_in_rspec.sort
  end

end

