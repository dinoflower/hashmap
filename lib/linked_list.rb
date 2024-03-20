# A class for individual nodes within the LinkedList.
class Node
  attr_accessor :key, :value, :next_node

  def initialize(key, value, next_node = nil)
    @key = key
    @value = value
    @next_node = next_node
  end
end

# A class for the LinkedList buckets to handle collisions within the Hashmap.
class LinkedList
  attr_reader :head

  def initialize(key, value)
    @head = Node.new(key,value)
  end

  # wait there shouldn't be nil heads - create the linked list when we create the first node
  def append(key, value)
    find_tail.next_node = Node.new(key,value)
  end

  def find_tail(node = @head)
    return node if tail?(node)

    find_tail(node.next_node)
  end

  def tail?(node)
    return true if node.next_node.nil?

    false
  end
end
