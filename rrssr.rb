require 'rubygems'
require 'sinatra'

require 'builder'

require 'nokogiri'
require 'open-uri'

require 'feed'

FEEDS = [
  "w24czestochowa",
  "emaus"
]

FEEDS.each do |feed|
  require File.join('feeds', feed)
end

get '/' do
  @feeds = []
  FEEDS.each do |feed|
    @feeds << constantize(feed).new
  end
  haml :index
end

get '/:feed_name.xml' do
  @feed = constantize(params[:feed_name]).new
  builder :feed
end

helpers do
  def constantize(str)
    Object.const_get(str.capitalize)
  end

  def feed_path(feed)
    [feed.class.name.downcase, ".xml"].join
  end

end
