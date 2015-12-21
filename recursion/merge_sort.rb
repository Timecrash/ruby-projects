def merge_sort(ary)
  return ary if ary.length == 1
  mid = ary.length / 2
  
  x = merge_sort(ary[0..(mid-1)])
  y = merge_sort(ary[mid..-1])
  
  return merge(x, y)
end
  
def merge(ary1, ary2)
  sorted = []
  
  (ary1.length + ary2.length).times do
    if ary1[0] <= ary2[0]
      sorted << ary1.slice!(0)
      ary1 << Float::INFINITY if ary1.empty? #Setting this to infinity since, hey, it's a big number.
    elsif ary2[0] <= ary1[0]
      sorted << ary2.slice!(0)
      ary2 << Float::INFINITY if ary2.empty?
    end
  end
  
  return sorted
end

#This is just to automate testing so I don't have to keep coming up with unsorted arrays.
x = []
20.times { x << rand(500) + 1 }
puts "Original: #{x}"
puts "Sorted: #{merge_sort(x)}"
