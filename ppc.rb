require 'sinatra'
require './datamodel'
require './seed'

class Ppc < Sinatra::Base

    get '/' do
        @timesuggestion = TimeSuggestion.first
        erb :userresponsetable
    end
    
    get '/event/new' do
        erb :addevent
    end

    post '/event/new' do
        event = Event.create :name => params[:eventname], :description => params[:eventdescription]
        redirect "/event/#{event.id}"
    end

    get '/event/:id/suggestion/new' do
        @event = Event.get params[:id]
        erb :addsuggestion
    end

    post '/event/:id/suggestion/new' do
        @event = Event.get params[:id]
        ts = TimeSuggestion.new({:time => params[:suggestiontime]})
        @event.time_suggestions << ts

        ts.save
        @event.save

        redirect "/event/#{@event.id}"
    end

    get '/event/:id' do
        @event = Event.get params[:id]
        erb :event
    end

end
