class ConnectFour
  require_relative "board"
  require_relative "player"

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

ConnectFour.new("Reimu","Marisa")
