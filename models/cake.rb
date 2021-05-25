class Cake


  def initialize
    @name = null
    @id = null
  end

  def initialize(a_name)
    @name = a_name
    @id = 1
  end

  def getName
    return @name
  end
end


=begin
class Cake < ActiveRecord::Base

end
=end
