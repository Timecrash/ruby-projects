require 'yaml'

class Hangman
	attr_reader :secret_word
	attr_accessor :guessed_letters, :word_display, :turn
	
	def initialize
		get_secret_word
		@guessed_letters, @word_display = Array.new, Array.new(@secret_word.length, "_")
		@turn = 0
	end
	
	def play
		while turn < 6
			update_display(turn)
			get_input
			if word_display.join == secret_word
				update_display(turn)
				puts "You win!"
				@turn = 7
			end
		end
		if turn != 7
			update_display(turn)
			puts "You lose! The correct word was '#{secret_word.capitalize}'"
		end
	end
		
	private
	def get_secret_word
		@secret_word = File.open("5desk.txt", "r").readlines[rand(61407)].chomp.upcase
		get_secret_word unless @secret_word.length.between?(5, 11)
	end
	
	def update_display(turn)
		case turn
			when 0
				puts %q{
				----
				|  |
				| 
				|  
				| 
				|
			}
			when 1
				puts %q{
				----
				|  |
				|  O
				|  
				| 
				|
			}
			when 2
				puts %q{
				----
				|  |
				|  O
				|  |
				| 
				|
			}
			when 3
				puts %q{
				----
				|  |
				|  O
				| /|
				| 
				|
			}
			when 4
				puts %q{
				----
				|  |
				|  O
				| /|\
				| 
				|
			}
			when 5
				puts %q{
				----
				|  |
				|  O
				| /|\
				| /
				|
			}
			when 6
				puts %q{
				----
				|  |
				|  O
				| /|\
				| / \
				|
			}
		end
		word_display.each { |i| print "#{i} " }
		puts ""
		puts "Missed Letters: #{guessed_letters.join(", ")}"
	end
	
	def get_input
		print "Input Command: "
		input = gets.chomp.upcase
		if input.length == 1 #Player guessed a letter
			if secret_word.include?(input)
				word_display.each_index do |index|
					word_display[index] = input if secret_word[index] == input
				end
			else
				guessed_letters << input if !guessed_letters.include?(input)
				@turn += 1
			end
		elsif input == "SAVE"
			save_game
			puts "Game has been saved."
		else #Assumes player tried to guess the secret word
			if input == secret_word
				@word_display = input.split(//)
			else
				@turn += 1
			end
		end
	end
end
	
def save_game
	Dir.mkdir('saves') unless Dir.exist?('saves')
	print "Save game title: "
	filename = "saves/#{gets.chomp}.yaml"
	File.open(filename, 'w') do |file|
		file.puts YAML.dump(self)
	end
end

def load_game
	puts "Please choose a save file:"
	puts Dir.entries("saves").join(", ")
	save_file = File.read("saves/#{gets.chomp}.yaml")
	YAML.load(save_file)
	puts "Game loaded!"
end

puts "Welcome to Hangman!"
puts "You can either guess a letter at a time, or try to solve the whole word at once."
type = ""
until type == "LOAD" || type == "START"
	puts "Would you like to LOAD a game, or START a new one?"
	type = gets.chomp.upcase
end

hangedman = type == "LOAD" ? load_game : Hangman.new
hangedman.play
