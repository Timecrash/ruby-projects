class ConnectFour
  attr_reader :board, :red_player, :black_player

  def initialize(red_name, black_name)
    @board = Board.new
    @red_player = Player.new(red_name, "R")
    @black_player = Player.new(black_name, "B")
    #play
  end

  def play
    initial_display
    loop do |turn|
      puts "Turn #{turn}"
      [red_player,black_player].each do |player|
        col = player.get_input
        row = board.get_empty_row(col)
        board.update_board(row, col, player.color)
        board.display_board

      end
    end
  end

  #private
  def initial_display
    puts "Connect Four!"
    board.display_board
  end

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
    @board = Array.new(7, Array.new(7, " "))
  end

  def display_board
    puts "\n0|1|2|3|4|5|6"
    puts "-------------"
    board.each do |row|
      puts row.join("|")
      puts "-|-|-|-|-|-|-"
    end
  end

  def update_board(row, col, color)
    if row != nil
      board[row][col] = color
    else
      puts "Invalid; the column is full."
    end
  end

  def check_for_win(row, col, color)


  def is_full?
    board.each do |row|
      return true if row.none?(" ")
    end
    return false
  end

  #private
  def get_empty_row(col)
    row = -1
    until row < -board.length
      if board[row][col] == " "
        return row
      else
        row -= 1
      end
    end
    return nil
  end
end

class Player
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def get_input
    col = -1
    until col.between?(0, 6)
      print "#{name}, please input a column number:"
      col = gets.chomp.to_i
    end
    return col
  end
end
