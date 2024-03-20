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
  def initialize
    @head = nil
    @size = 0
  end

  # create helper method to find tail
  def append(key, value)
    if find_tail.nil?
      @head = Node.new(key,value)
    else
      find_tail.next_node = Node.new(key,value)
    end
  end

  private

  # will this break if there is no head or tail?
  def find_tail(node)
    return node if tail?(node = @head)

    find_tail(node.next_node)
  end

  def tail?(node)
    return true if node.next_node.nil?

    false
  end
end
