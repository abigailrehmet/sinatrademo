class Cake


  def initialize
    @name = null
    @id = null
  end

  def initialize(a_name)
    @name = a_name
    @id = 1
  end

  def getName()
    return @name
  end

  def getId()
    return @id
  end

  def setId(a_id)
    @id = a_id
  end

  def setName(a_name)
    @name = a_name
  end
end


=begin
class Cake < ActiveRecord::Base

end
=end
