class Knight
  attr_accessor :location, :moves, :previous
  
  def initialize(coordinates, previous=nil)
    @location = coordinates
    possible_moves(coordinates)
    @previous = previous
  end

  def possible_moves(destination)
    @moves = [[(destination[0] + 2), (destination[1] + 1)],
            [(destination[0] + 2), (destination[1] - 1)],
            [(destination[0] - 2), (destination[1] + 1)],
            [(destination[0] - 2), (destination[1] - 1)],
            [(destination[0] + 1), (destination[1] + 2)],
            [(destination[0] + 1), (destination[1] - 2)],
            [(destination[0] - 1), (destination[1] + 2)],
            [(destination[0] - 1), (destination[1] - 1)]]
            
    @moves.reject! do |cell|
      cell.any? { |x| x < 0 } || cell.any? { |x| x > 7 }
    end
    return moves
  end
end

def knight_moves(start,destination)
  queue, route, checked = [], [], []
  turns = 0
  knight = Knight.new(start)

  until knight.location == destination
    knight.moves.each do |move|
      unless checked.include?(move)
        queue << Knight.new(move, knight)
        checked << move
      end
    end
    knight = queue.shift
    turns += 1
  end
  
  route << knight.location
  until knight.previous.nil?
    route << knight.previous.location
    knight = knight.previous
  end
  
  puts "Your route is #{route.reverse.each { |move| move } }."
  puts "You got there in #{turns} turns."  
end

knight_moves([0,0],[4,3])
