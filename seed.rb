require './datamodel'

e=Event.create(:name => "TestEvent", :description => "Testetsttesttest")
u=User.create(:name => "TestUser")
ts=TimeSuggestion.create(:time => DateTime.now)
ur=UserResponse.create(:response => true)
ur2=UserResponse.create(:response => false)

u.user_responses << ur
ts.user_responses << ur
u.user_responses << ur2
ts.user_responses << ur2

u.save
ts.save

e.users << u
e.time_suggestions << ts

e.save
