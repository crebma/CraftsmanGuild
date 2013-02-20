require 'sinatra'

get '/' do
  erb :index
end

get '/map' do
  erb :map
end

get '/events' do
  erb :events
end

get '/resources' do
  erb :resources
end

get '/topics' do
  erb :topics
end
