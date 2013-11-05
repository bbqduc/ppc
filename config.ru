require './ppc'

enable :sessions
use Rack::Session::Cookie, 
    :key => 'ASDASD',
    :path => '/',
    :expire_after => 14400,
    :secret => 'secret_stuff'

run Ppc.new
