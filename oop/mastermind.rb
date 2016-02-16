class Mastermind
	attr_reader :player, :computer, :secret_code
	
	def initialize(player_type)
		@player = Player.new(player_type)
		@computer = Computer.new
		@secret_code = get_code
		secret_code = get_code unless is_valid?(@secret_code)
	end

	def play
		catch :playing do
			12.times do |turn|
				puts "Turn #{turn+1}. Make your guess:"
				if player.type == "codebreaker"
					guess = player.input_code
					if is_valid?(guess)
						display_answer_key(verify(guess))
					else
						puts "Invalid colors found."
						puts "Valid colors are red, blue, green, yellow, orange, and purple."	
					end
				else
					guess = computer.make_guess
					puts "The computer guesses #{guess.join(", ")}."
					answer_key = verify(guess)
					display_answer_key(answer_key)
					computer.update_final_key(answer_key)
				end
				if guess == secret_code
					puts "The Codebreaker wins!"
					throw :playing
				end
			end
			puts "You can never beat a TRUE mastermind!"
			throw :playing
		end
		puts "Game over!"
	end
	
	def display_answer_key(answer_key)
		puts "The answer key is: #{answer_key.join(", ")}"
		puts "\n"
	end

	def give_instructions
		puts "In Mastermind, guess the four-color secret code in twelve tries or less!"
		puts "Your valid choices are red, blue, green, yellow, orange, and purple."
		puts "After a guess, I'll tell you whether the color and position was correct (White), or if the color was correct but in the wrong place (Black)."
	end
	
	def is_valid?(guess)
		guess.all? do |color|
			computer.key.values.any? { |value| color == value }
		end
	end
	
	def get_code
		if player.type == "codemaster"
			puts "Input secret code of four colors."
			puts "Valid choices are red, blue, green, yellow, orange, and purple."
			player.input_code
		else
			computer.create_code
		end
	end

	def verify(guess)
		answer_key = Array.new(4, "Miss")
		guess.each_with_index do |color, index|
			answer_key[index] = "Black" if secret_code.include?(color)
			answer_key[index] = "White" if color == secret_code[index]
		end
		return answer_key
	end
end

class Player
	attr_reader :type
	
	def initialize(type)
		@type = type
	end
	
	def input_code
		return gets.chomp.downcase.split(/\W+/)
	end
end

class Computer
	attr_reader :key, :final_code, :code, :black_values
	
	def initialize
		@key = {"0": "red", "1": "blue", "2": "green", "3": "yellow", "4": "orange", "5": "purple"}
		@final_code, @code, @black_values = Array.new(4), Array.new(4), Array.new
	end

	def create_code
		return code.collect! { |x| x = generate_random_color }
	end
	
	def make_guess
		final_code.each_index do |index|
			if final_code[index].nil?
				if !black_values.empty?
					code[index] = black_values.shuffle.first
				else
					code[index] = generate_random_color
				end
			else
				code[index] = final_code[index]
			end
		end
		return code
	end
	
	def generate_random_color
		key[rand(6).to_s.to_sym]
	end
	
	def update_black_values
		black_values.delete_if { |color| final_code.include?(color) }
	end
	
	def update_final_key(answer_key)
		update_black_values
		answer_key.each_with_index do |answer, index|
			final_code[index] = code[index] if answer == "White"
			black_values << code[index] if answer == "Black" && !final_code.include?(code[index])
		end
		black_values.uniq!
	end
end

puts "Mastermind!"
player_type = ""
until player_type == "codemaster" || player_type == "codebreaker"
	print "Will you play the Codemaster, or the Codebreaker?"
	player_type = gets.chomp.downcase
end

mastermind = Mastermind.new(player_type)
mastermind.give_instructions
mastermind.play
