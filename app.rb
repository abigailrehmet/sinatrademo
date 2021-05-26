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

cake = Cake.new("hi")

get '/' do
  erb :add
end

post '/show' do
  @name = params['cname']
  cake.setName('#{@name}')
  @conn = PG.connect(dbname: 'cakedb', user: 'postgres', password: 'J3&ZD~Y68M"R`9fr')
  #put the cake into db
  @conn.exec("INSERT INTO info (name) VALUES ('#{@name}')")
  @conn.close if @conn
  erb :show
end


get '/show.json' do
  @conn = PG.connect(dbname: 'cakedb', user: 'postgres', password: 'J3&ZD~Y68M"R`9fr')
  #get cake name from db
  res = @conn.exec("select name from info order by id desc limit 1;")
  c = Cake.new(res[0]["name"])
  @cakename = c.getName()
  #get the cake id from db
  res = @conn.exec("SELECT id FROM info WHERE name = '#{@cakename}' limit 1;")
  @id = res[0]["id"]
  c.setId(@id)
  @conn.close if @conn
  json :yourCake => c
end

post '/index' do
  erb :index
end

get '/index.json' do
  @conn = PG.connect(dbname: 'cakedb', user: 'postgres', password: 'J3&ZD~Y68M"R`9fr')
  res = @conn.exec("SELECT name FROM info;")
  @conn.close if @conn
  @cake_arr = Array.new
  res.each do |cake|
    @cake_arr.push(cake)
  end
  json :cakeList => @cake_arr
  #"#{@cake_arr}"
end

post '/edit' do
  #@old_name = params['oldName']
  erb :edit
end

post '/delete' do
  #@old_name = params['oldName']
  erb :delete
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
