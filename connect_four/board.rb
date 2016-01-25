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
