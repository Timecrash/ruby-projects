def stock_picker(stocks)
  best_profit = 0
  best_dates = Array.new(2)

  stocks.each_with_index do |buy_price, buy_day|
    stocks[ buy_day + 1..-1 ].each_with_index do |sell_price, sell_day|
      if sell_price - buy_price > best_profit
        best_profit = sell_price - buy_price
        best_dates = [ buy_day, ( sell_day + buy_day + 1 ) ] #The selling array starts at buy_day + 1, so this needs to compensate for that.
      end
    end
  end

  puts "Buy on day #{best_dates[0] + 1}, sell on day #{best_dates[1] + 1}."
  return best_dates
end

puts "Enter a list of stock prices: "
stocks = gets.split(/\D/).map(&:to_i)

stock_picker(stocks)
