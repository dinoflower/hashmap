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

  def append(key, value)
    find_tail.next_node = Node.new(key,value)
  end

  def contains?(key, node = @head)
    return true if node.key == key

    return false if tail?(node)

    contains?(key, node = next_node)
  end

  # may need to return node in general later, if so, retool Hashmap #get method
  def find(key, node = @head)
    return nil if node.nil?

    each_node do |node|
      return node.value if node.key == key
    end
  end

  private

  def find_tail(node = @head)
    return node if tail?(node)

    find_tail(node.next_node)
  end

  def tail?(node)
    return true if node.next_node.nil?

    false
  end

  # this method is probably fine, might need to be public
  def each_node
    node = @head
    until node.nil?
      yield node
      node = node.next_node
    end
  end
end
