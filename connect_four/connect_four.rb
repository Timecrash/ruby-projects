class ConnectFour
  attr_reader :board, :red_player, :black_player

  def initialize(red_name, black_name)
    @board = Board.new
    @red_player = Player.new(red_name, "R")
    @black_player = Player.new(black_name, "B")
  end

  #Array should have seven values, assuming the cell checked on is in the center.
  def has_won?(array, color)
    x = 0
    until x > 3 do
      if array[x] == color
        if array[x+1] == color
          if array[x+2] == color
            if array[x+3] == color
              return true
            end
            x += 4 #Skips to the value after the miss.
            next
          end
          x += 3
          next
        end
        x += 2
        next
      end
      x += 1
    end
    return false
  end
end

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(7, Array.new(7, "-"))
  end

  def display_board
    board.each do |row|
      puts row.join("|")
    end
  end

  def update_board(col, color)
    row = -1

    until row < -board.length
      board[row][col] == "-" ? board[row][col] = color : row -= 1
    end

    if row < -

    if !is_full?(col)
      board[row][col] = color
    else
      puts "Invalid; the column is full."
    end
  end

  def is_full?(col)
    row = -1
    until row < -board.length
      return false if board[row][col] == "-"
      row -= 1
    end
    return true
  end
end

class Player
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def get_input
    col = nil
    until col.between?(0, 6)
      print "Please input a column number:"
      col = gets.chomp.to_i
    end
    return col
  end
end
