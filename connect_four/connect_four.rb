class ConnectFour
  attr_reader :board, :red_player, :black_player

  def initialize(red_name, black_name)
    @board = Board.new
    @red_player = Player.new(red_name, "R")
    @black_player = Player.new(black_name, "B")

    play
  end

  def play
    puts "Connect Four!"
    board.display_board
    catch :playing do
      loop do
        [red_player,black_player].each do |player|
          col = player.get_input
          row = board.get_empty_row(col)
          board.update_board(row, col, player.color)
          board.display_board
          if row != nil
            test_array = board.check_for_win(row, col, player.color)
            test_array.each do |test|
              if has_won?(test, player.color)
                puts "#{player.name} has won!"
                throw :playing
              end
            end
            if board.is_full?
              puts "The board is full!"
              throw :playing
            end
          end
        end
      end
    end
    puts "Game over!"
  end

  private
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
    @board = Array.new(7) { Array.new(7, " ") }
  end

  def display_board
    puts "\n0|1|2|3|4|5|6"
    board.each do |row|
      puts row.join("|")
    end
    puts "-------------"
  end

  def update_board(row, col, color)
    if row != nil
      board[row][col] = color
    else
      puts "Invalid; the column is full."
    end
  end

  def get_empty_row(col)
    row = 6
    until row < 0
      return row if board[row][col] == " "
      row -= 1
    end
    return nil
  end

  def check_for_win(row, col, color)
    test_array = []
    test_array.push(horizontal_check(row, col, color),
                    vertical_check(row, col, color),
                    r_diagonal_check(row, col, color),
                    l_diagonal_check(row, col, color))
    return test_array
  end

  def is_full?
    board.each do |row|
      return true if row.none? { |val| val == " " }
    end
    return false
  end

  private
  def horizontal_check(row, col, color)
    array = []
    x = col - 3
    until x > 6 do
      if x.between?(0,6)
        array << board[row][x]
      end
      x += 1
    end
    return array
  end

  def vertical_check(row, col, color)
    array = []
    y = row - 3
    until y > 6 do
      if y.between?(0,6)
        array << board[y][col]
      end
      y += 1
    end
    return array
  end

  def r_diagonal_check(row, col, color)
    array = []
    x = col - 3
    y = row - 3
    until y > 6 || x > 6 do
      if x.between?(0,6) && y.between?(0,6)
        array << board[y][x]
      end
      x += 1
      y += 1
    end
    return array
  end

  def l_diagonal_check(row, col, color)
    array = []
    x = col + 3
    y = row - 3
    until y > 6 || x < 0 do
      if x.between?(0,6) && y.between?(0,6)
        array << board[y][x]
      end
      x -= 1
      y += 1
    end
    return array
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
      print "#{name}, please input a column number: "
      col = gets.chomp.to_i
    end
    return col
  end
end

ConnectFour.new("Reimu","Marisa")
