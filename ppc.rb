require 'sinatra'
require './datamodel'
#require './seed'

class Ppc < Sinatra::Base

    get '/' do
        @events = Event.all
        erb :index
    end

    get '/event/new' do
        erb :addevent
    end

    post '/event/new' do
        event = Event.create :name => params[:eventname], :description => params[:eventdescription]
        redirect "/event/#{event.id}"
    end

    post '/event/:id/suggestion/:sid/comments/new' do
        event = Event.get params[:id]
        timesuggestion = event.time_suggestions.get params[:sid]

        puts "paramsseja"
        puts params["commentmessage_#{timesuggestion.id}"]

        comment = Comment.new :comment => params["commentmessage_#{timesuggestion.id}"]
        timesuggestion.comments << comment

        timesuggestion.save
        comment.save

        session[:opencomments] = "timesuggestion_#{timesuggestion.id}"
        redirect "/event/#{event.id}"
    end

    get '/event/:id/suggestion/new' do
        @event = Event.get params[:id]
        erb :addsuggestion
    end

    post '/event/:id/suggestion/new' do
        @event = Event.get params[:id]

        existing = @event.time_suggestions.first :time => params[:suggestiontime]
        if existing
            redirect "/event/#{@event.id}"
        end

        ts = TimeSuggestion.new({:time => params[:suggestiontime]})
        @event.time_suggestions << ts

        @event.users.each do |u|
            ur = UserResponse.create :response => false
            u.user_responses << ur
            ts.user_responses << ur

            u.save
        end

        ts.save
        @event.save

        redirect "/event/#{@event.id}"
    end

    get '/event/:id/suggestion/:sid' do
        @event = Event.get params[:id]
        timesuggestion = @event.time_suggestions.get params[:sid]
        erb :userresponsetable, :locals => { :timesuggestion => timesuggestion }
    end
    

    post '/event/:id/submitsuggestions' do

        event = Event.get params[:id]

        timesuggestions = event.time_suggestions
        timesuggestions.each do |ts|
            puts "ja halloota"
            puts params["commentmessage_#{ts.id}"]
            if params["commentmessage_#{ts.id}"] != ""
                redirect "/event/#{event.id}/suggestion/#{ts.id}/comments/new", 307 # redirect as post
            end
        end

        if params[:username] == ""
            redirect "/event/#{event.id}"
        end


        user = User.first_or_create :name => params[:username]

        timesuggestions.each do |ts|
            ur = UserResponse.first :user => user, :time_suggestion => ts
            resp = params["response_#{ts.id}"] == "on"
            if ur
                puts "haara1"
                ur.response = resp
                puts ur.save
            else
                puts "haara2"
                ur = UserResponse.create :user => user, :time_suggestion => ts, :response => resp
                ts.user_responses << ur
                user.user_responses << ur
                event.users << user
                puts ts.save
            end
        end
        user.save
        event.save
        redirect "/event/#{event.id}"
    end

    get '/event/:id' do
        @event = Event.get params[:id]
        @timesugs = @event.time_suggestions.all :order => [:time.asc]
        erb :event
    end

end
