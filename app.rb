require 'sinatra'

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
