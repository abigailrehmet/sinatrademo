require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'
require_relative 'models/cake.rb'
require 'pg'
require 'uri'
require 'net/http'

#class App < Sinatra::Base

=begin
  get '/' do
    line_num = 0
    output = ""
    File.open('cake.list').each do |line|
      output += "#{line_num += 1}. #{line} <br/>"
    end
    output
  end
#end
=end


get '/' do
  erb :add
end

post '/show' do
  @name = params['cname']
  @cake = Cake.new("#{@name}")


  @conn = PG.connect(dbname: 'cakedb', user: 'postgres', password: 'J3&ZD~Y68M"R`9fr')
  @conn.exec("INSERT INTO info (name) VALUES ('#{@name}')")
  @conn.close if @conn

  #@cake.getName


  erb :show
end

post '/index' do
  #cake = Cake.new("cake name")
  #json :cakeName => cake.name
  erb :index
end

=begin
get('/index') {
  erb :cakes
}
=end

=begin
#create a cake array from the cake file and fill
cakes = Array.new
cakeslist = File.new("cake.list", "r")
    while (line = cakeslist.gets)
        cakes.push(line[0...-1])
    end
cakeslist.close

#turn the array into JSON string
get '/cakes.json' do
    json :cakelist => cakes
end
=end





#----------------------
#by default, show the list
=begin

get('/') {
  @cakes = Cake.all
  erb :index
}

#add cakes
get('/add') {
  @cakes = Cake.all
  erb :add
}

#edit cakes
get('/edit') {
  @cakes = Cake.all
  erb :edit
}

#delete cakes
get('/delete') {
  @cakes = Cake.all
  erb :delete
}

#show cakes
get('/show') {
  @cakes = Cake.all
  erb :show
}

#list of cakes
get('/index') {
  @cakes = Cake.all
  erb :index
}
=end
