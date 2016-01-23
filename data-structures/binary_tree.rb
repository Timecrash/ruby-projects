require "benchmark"

class Node
  attr_reader :value
  attr_accessor :parent, :left_child, :right_child
  
  def initialize(value)
    @value = value
  end
  
  def assign_child(child)
    if child.value < value
      if @left_child.nil?
        @left_child = child
        @left_child.parent = self
      else
        @left_child.assign_child(child)
      end
    else
      if @right_child.nil?
        @right_child = child
        @right_child.parent = self
      else
        @right_child.assign_child(child)
      end
    end
  end
  
  def breadth_first_search(target)
    parent = self
    queue = [parent]
    
    until queue.size == 0
      return parent if parent.value == target
      if parent.left_child
        if parent.left_child.value == target
          return parent.left_child
        else
          queue << parent.left_child
        end
      end
      if parent.right_child
        if parent.right_child.value == target
          return parent.right_child
        else
          queue << parent.right_child
        end
      end
      queue.shift
      parent = queue[0]
    end
    return nil
  end
  
  def depth_first_search(target)
    parent = self
    stack = [parent]
    
    until stack.size == 0
      return parent if parent.value == target
      stack << parent.right_child if parent.right_child
      stack << parent.left_child if parent.left_child
      parent = stack[-1]
      stack.pop
    end
  end
  
  #I stumbled upon my own recursive solution that isn't quite what the project asked for.
  #I decided to include it, mostly to show off. :P
  def dfs_rec_alt(target)
    return self if value == target
    l = left_child.dfs_rec_alt(target) if left_child
    r = right_child.dfs_rec_alt(target) if right_child
    if !l.nil?
      return l
    elsif !r.nil?
      return r
    elsif l.nil? && r.nil?
      return nil
    end
  end
end

def build_tree(array)
  mid = array.size / 2
  root = Node.new(array[mid])
  array.delete_at(mid)

  until array.size == 0
    mid = array.size / 2
    child = Node.new(array[mid])
    array.delete_at(mid)
    root.assign_child(child)
  end
  return root  
end

def dfs_rec(node, target)
  return node if node.value == target
  dfs_rec(node.left_child, target) if node.left_child
  dfs_rec(node.right_child, target) if node.right_child
end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = build_tree(array)

target = 4
bfs_time = Benchmark.realtime { puts tree.breadth_first_search(target) }
dfs_time = Benchmark.realtime { puts tree.depth_first_search(target) }
dfs_rec_time = Benchmark.realtime { puts dfs_rec(tree, target) }
alt_time = Benchmark.realtime { puts tree.dfs_rec_alt(target) }

puts ""

puts "BFS Elapsed Time:" + "#{ (bfs_time * 1000).round(3) } milliseconds.".rjust(40)
puts "DFS Elapsed Time:" + "#{ (dfs_time * 1000).round(3) } milliseconds.".rjust(40)
puts "Recursive DFS Elapsed Time:" + "#{ (dfs_rec_time * 1000).round(3) } milliseconds.".rjust(30)
puts "Alternate Recursive DFS Elapsed Time:" + "#{ (alt_time * 1000).round(3) } milliseconds.".rjust(20)
