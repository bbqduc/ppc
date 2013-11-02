require 'sinatra'
require './datamodel'

class Ppc < Sinatra::Base

    get '/' do
        "Hello world!"
    end

end
