def bubble_sort(array)
    bubble_sort_by(array) { |left, right| left - right }
end

def bubble_sort_by(array)
    max = array.length - 1
    max.times do
        array.each_with_index do |item, index|
            if index >= max
                break
            elsif yield(array[index], array[index+1]) > 0
                array[index] = array[index + 1]
                array[index + 1] = item
            end
        end
    end
    return array
end

#Have yet to figure out a good way to change between an array of Strings and an array of Integers on the fly.
puts "Enter an array to be sorted, without the brackets: "
array = gets.split(/\W+/)

bubble_sort_by(array) { |left, right| left.length <=> right.length }

#The original bubble_sort code, for the sake of completeness.
=begin
def bubble_sort(array)
    max = array.length - 1
    max.times do
        array.each_with_index do |item, index|
            if index >= max
                break
            elsif item > array[index+1]
                array[index] = array[index+1]
                array[index + 1] = item
            end
        end
    end
    return array
end
puts "Enter an array to be sorted, without the brackets: "
array = gets.split(/\D/).map(&:to_i)
bubble_sort(array)
=end
