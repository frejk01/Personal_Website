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
        user_hash:    nil
    }
    return start_hash
end

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

get('/') do

    rand_num = get_file_count("./public/splash/")
    splash_dir = "splash/splash-#{rand_num}.jpg"

    slim(:index, locals:{user:session[:user_hash],splash:splash_dir})
end