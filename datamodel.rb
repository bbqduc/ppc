require './datamapper_setup'

class Event
    include DataMapper::Resource

    property :id,           Serial
    property :name,         String, :required => true
    property :description,  String, :required => true

    has n, :time_suggestions
    has n, :users
end

class TimeSuggestion
    include DataMapper::Resource

    property :id,   Serial
    property :time, DateTime, :required => true

    belongs_to :event

    has n, :user_responses
end

class User
    include DataMapper::Resource

    property :id,     Serial
    property :name,   String, :required => true, :index => true, :unique => true

    has n, :user_responses
end

class UserResponse
    include DataMapper::Resource

    property :id,     Serial
    property :answer, Boolean

    belongs_to :time_suggestion
    belongs_to :user
end

puts "Initializing DataMapper"

DataMapper.finalize
DataMapper.auto_migrate!
DataMapper.auto_upgrade!
