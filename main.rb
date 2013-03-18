require 'sinatra'
require 'data_mapper'
require 'json'
require 'net/https'

DataMapper.setup(:default, ENV['HEROKU_POSTGRESQL_MAROON_URL'] || 'postgres://postgres:password@localhost:5432/cg')

class Event
  include DataMapper::Resource

  property :id, Serial
  property :title, String, :length => 256
  property :description, String, :length => 1024
  property :date, Date
  property :event_link, String, :length => 256

  has n, :presenters

  def self.current
    first(:date.gt => Date.today.prev_day)
  end

end

class Presenter
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :bio, String, :length => 1024
  property :twitter, String

  belongs_to :event
end

DataMapper.finalize.auto_upgrade!

get '/' do
  @event = Event.current
  erb :index
end

get '/map' do
  erb :map
end

get '/events' do
  @events = Event.all(:date.lt => Date.today.prev_day, :order => [ :date.desc ])
  erb :events

end

get '/presenters' do
  JSON.generate Presenter.all()
end

get '/resources' do
  erb :resources
end

get '/topics' do
  erb :topics
end
