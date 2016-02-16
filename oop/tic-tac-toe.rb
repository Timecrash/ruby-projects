class TicTacToe
	attr_reader :players, :board
	
	def initialize(x_name, o_name, x_type, o_type)
		@board = Board.new
		@players = [
					x_type == "human" ? Human.new(x_name, "X", x_type) : Computer.new(x_name, "X", x_type),
					o_type == "human" ? Human.new(o_name, "O", o_type) : Computer.new(o_name, "O", o_type)
		]
	end

	def play
		board.draw_board
		catch :playing do
			loop do
				players.each do |player|
					if player.type == "human"
						position = player.get_position
					else
						position = player.choose_position(position)
						puts "#{player.name} chooses position: #{position}"
						player.update_wins(position)
					end
					board.update_board(position, player.symbol)
					board.draw_board
					if board.is_won?(player.symbol)
						puts "#{player.name} wins!"
						throw :playing
					elsif board.is_full?
						puts "It's a draw!"
						throw :playing
					end
				end
			end
		end
		puts "Game over!"
	end
end

class Player
	attr_reader :name, :symbol, :type
	
	def initialize(name, symbol, type)
		@name = name
		@symbol = symbol
		@type = type
	end
end

class Human < Player
	def get_position
		print "#{name}, pick a position:"
		position = gets.to_i
	end
end

=begin
Computer needs to:
	-Detect if a space is occupied when selecting its move (buggy)
	--This is probably because possible_wins might not return the array correctly. Needs more testing.
	-Block a win by the other player (not implemented)
	-Win if it can (not implemented)
	-If there are no possible wins (if possible_wins is empty), choose a free position at random
	-Other things I'm probably forgetting
=end
class Computer < Player
	attr_reader :possible_wins
	
	def initialize(name, symbol, type)
		super(name, symbol, type)
		@possible_wins = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
	end
	
	def choose_position(position)
		update_wins(position)
		new_wins = possible_wins.flatten
		return new_wins.group_by(&:itself).values.max_by(&:size).first
	end
		
	def update_wins(position)
		possible_wins.each_index do |index|
			possible_wins.delete_at(index) if possible_wins[index].include?(position)
		end
	end
end
	
class Board
	attr_reader :board
	
	def initialize
		@board = Array.new(3) { Array.new(3, " ") }
	end

	def draw_board
		board.each_with_index do |row, row_index|
			row.each_with_index do |position, column_index|
				print " #{position} "
				print "|" unless column_index >= 2
			end
			print "\n"
			puts "---|---|---" unless row_index >= 2
		end
	end

	def update_board(position, symbol)
		board.each_index do |x|
			board[x].each_index do |y|
				current_position = get_position(x, y)
				if current_position == position
					if board[x][y] == " "
						board[x][y] = symbol
						return
					else
						puts "Invalid choice; space already filled."
						return
					end
				end
			end
		end
		puts "Invalid choice; not a number 1-9."
	end

	def is_won?(symbol)
		board.each_index do |x|
			return true if board[x].all? { |value| value == symbol } #Checks for horizontal match
			col_array = []
			(0..2).each { |y| col_array << board[y][x] }
			return true if col_array.all? { |value| value == symbol } #Checks for vertical match
			if x == 1 && board[x][x] == symbol #Checks diagonal matches, if we're on the center row.
				if board[x-1][x-1] == board[x][x] && board[x][x] == board[x+1][x+1]
					return true
				elsif board[x-1][x+1] == board[x][x] && board[x][x] == board[x+1][x-1]
					return true
				end
			end
		end
		return false
	end

	def is_full?	
		board.all? do |x|
			x.all? { |y| y != " " }
		end
	end

	private
	def get_position(x, y)
		return (x * board.size) + (y + 1)
	end
end

puts "Tic-Tac-Toe!"
print "Will 'X' be a Human or Computer?"
x_type = gets.chomp.downcase
print "Name for 'X':"
x_name = gets.chomp
print "Will 'O' be a Human or Computer?"
o_type = gets.chomp.downcase
print "Name for 'O':"
o_name = gets.chomp

tictactoe = TicTacToe.new(x_name, o_name, x_type, o_type)
tictactoe.play
