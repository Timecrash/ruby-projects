def caesar_cipher(input_string, shift)
  ascii = input_string.scan(/./)
  ascii.collect!(&:ord)
  caesar = []

  ascii.each do |letter|
    if letter.between?(65, 90)
      letter += shift
      if letter > 90
        letter -= 26
      elsif letter < 65
        letter += 26
      end
    elsif letter.between?(97, 122)
      letter += shift
      if letter > 122
        letter -= 26
      elsif letter < 97
        letter += 26
      end
    end
    caesar << letter
  end

  caesar.collect!(&:chr)
  puts "Encrypted: #{caesar.join}"
end

puts "Please input a string: "
input_string = gets.chomp

puts "Please input a shift factor (Positive: right shift; Negative: left shift)"
shift = gets.to_i

caesar_cipher(input_string, shift)
