def substrings(text, dictionary)
  substring = Hash.new(0)

  words = text.downcase.split(/\b/)

  dictionary.each do |dict|
    words.each do |word|
      substring[dict] += 1 if word.index(dict) != nil
    end
  end

  substring = substring.sort_by { |k, v| v }
  substring.reverse!.each { |k, v| puts "#{k}: #{v}" }
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts "Please input your desired string: "
text = gets.chomp

substrings(text, dictionary)
