require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'
require_relative 'models/cake.rb'
require 'pg'
require 'uri'
require 'net/http'


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

class App < Sinatra::Base
  get '/' do
    erb :add
  end
end

class App < Sinatra::Base
  post '/show' do
    @name = params['cname']
    cake.setName('#{@name}')
    @conn = PG.connect(dbname: 'cakedb', user: 'postgres', password: 'J3&ZD~Y68M"R`9fr')
    #put the cake into db
    @conn.exec("INSERT INTO info (name) VALUES ('#{@name}')")
    @conn.close if @conn
    erb :show
  end
end

class App < Sinatra::Base
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
end

class App < Sinatra::Base
  post '/index' do
    erb :index
  end
end

class App < Sinatra::Base
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
end

class App < Sinatra::Base
  post '/edit' do
    erb :edit
  end
end

class App < Sinatra::Base
  get '/edit.json' do
    @conn = PG.connect(dbname: 'cakedb', user: 'postgres', password: 'J3&ZD~Y68M"R`9fr')
    res = @conn.exec("SELECT name FROM info;")
    @conn.close if @conn
    @cake_arr = Array.new
    res.each do |cake|
      @cake_arr.push(cake)
    end
    json :cakeList => @cake_arr
  end
end

class App < Sinatra::Base
  post '/editBtn' do
    if params['edit']
      @newName = params['newName'] #fill with something
      @oldName = params['cake'] #fill with something
      #{}"#{@newName} , #{@oldName}"
      @conn = PG.connect(dbname: 'cakedb', user: 'postgres', password: 'J3&ZD~Y68M"R`9fr')
      @conn.exec("UPDATE info SET name = '#{@newName}' WHERE name = '#{@oldName}';")
      @conn.close if @conn
    end
    if params['delete']
      @name = params['cake'] #fill with something
      @conn = PG.connect(dbname: 'cakedb', user: 'postgres', password: 'J3&ZD~Y68M"R`9fr')
      @conn.exec("delete from info where name = '#{@name}';")
      @conn.close if @conn
    end
    erb :edit
  end
end

class App < Sinatra::Base
  post '/deleteBtn' do
    @name = params['cake'] #fill with something
    @conn = PG.connect(dbname: 'cakedb', user: 'postgres', password: 'J3&ZD~Y68M"R`9fr')
    @conn.exec("delete from info where name = '#{@name}';")
    @conn.close if @conn
    erb :edit
  end
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
