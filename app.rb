# Getting all requiered libraries and
# the model file with essential functions
#
require 'sinatra'
require 'slim'
require 'sqlite3'
require 'bcrypt'
require 'byebug'
require_relative './model.rb'

# Enables Sessions in Sinatra in order to store
# local data temporarily
#
enable :sessions


# Defienes a hash with essential information
# about the new user
# login_status : False = Not logged in, True = Logged in
#
def setup()

    start_hash = {
        login_status: false,
        user_hash:    {
            username: nil,
            perm: 0
        }
    }
    return start_hash
end

# Assigns values created in setup() to
# session cookies so they can be stored
# locally. this happens if the user is
# neither logged in nor confirmed
# guest. If the user has an id assigned
# It will validate that user as logged in
#
before do
    if session[:login_status] == nil
        hash = setup()
        session[:login_status] = hash[:login_status]
        session[:user_hash] = hash[:user_hash]
        redirect('/')
    end
    if session[:status] != true && session[:id] != []
        session[:status] = true
    end
end

# Displays the splash screen.
# With help of get_file_count(dir) this get block
# retrieves the randomly selected image and sends
# it to slim(:index) in :locals as splash,
# wich is a jpeg file directory in the form of:
# "splash/splash-[RANDOM INT].jpg" this always works given
# that all files in the "./public/splash" folder are
# jpeg images.
#
get('/') do

    rand_num = get_file_count("./public/splash/")
    splash_dir = "splash/splash-#{rand_num}.jpg"

    slim(:index, locals:{user:session[:user_hash],status:session[:login_status],splash:splash_dir})
end

get('/login') do
end

post('/login') do
end

get('/register') do
end

post('/register') do
end

get('/*') do
    redirect('/error/404')
end

get('/error/:code') do
    slim(:error, locals:{user:session[:user_hash],status:session[:login_status], code:params[:code]})
end