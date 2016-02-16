module Enumerable
    def my_each
        return self unless block_given?
        for i in self do
            yield(i)
        end
        
    end
    
    def my_each_with_index
        return self unless block_given?
        index = 0
        self.my_each do |item|
            yield(item, index)
            index += 1
        end
    end
    
    def my_select
        return self unless block_given?
        array = []
        self.my_each { |item| array << item if yield(item) }
        return array
    end
    
    def my_all?
        return self unless block_given?
        self.my_each { |item| return false if !yield(item) }
        return true
    end
    
    def my_any?
        return self unless block_given?
        self.my_each { |item| return true if yield(item) }
        return false
    end
    
    def my_none?
        return self unless block_given?
        self.my_each { |item| return false if yield(item) }
        return true
    end
    
    #Would self.length be considered cheating? The world may never know.
    def my_count
        return self unless block_given?
        i = 0
        self.my_each { |item| i += 1 }
        return i
    end
    
    def my_map
		return self unless block_given?
		new_array = []
		self.my_each { |item| new_array << yield(item) }
		return new_array
	end
	
	def my_map_proc(proc)
		new_array = []
		self.my_each { |item| new_array << proc.call(item) }
		return new_array
	end
	
	def my_map_proc_block(proc=nil)
		new_array = []
		self.my_each_with_index do |item, index|
			if proc != nil
				new_array << proc.call(item)
				new_array[index] += yield(item) if block_given
			end
		end
		return new_array
	end
	
	def my_inject(initial=0)
		return self unless block_given?
		self.my_each { |item| initial += yield(initial, item) }
		return initial
	end
	
end

def multiply_els(array)
	puts array.my_inject
end

multiply_els([1,2,3,4,5])
