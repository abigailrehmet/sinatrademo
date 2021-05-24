require 'sinatra'
require 'sinatra/json'

=begin
#displays Hello, world
get '/' do
  "Hello, world"
end
=end


get '/' do
  line_num = 0
  output = ""
  File.open('cake.list').each do |line|
    output += "#{line_num += 1}. #{line} <br/>"
  end
  output
end


get('/index') {
  erb :cakes
}

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
