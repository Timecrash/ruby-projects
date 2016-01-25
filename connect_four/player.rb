class Player
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def get_input
    col = -1
    until col.between?(0, 6)
      print "#{name}, please input a column number: "
      col = gets.chomp.to_i
    end
    return col
  end
end
