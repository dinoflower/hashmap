# A class for individual nodes within the LinkedList.
class Node
  attr_accessor :key, :value, :next_node

  def initialize(key, value, next_node = nil)
    @key = key
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  # don't need to track tail if the nodes know what they point to
  def initialize
    @head = nil
    @size = 0
  end

  # create helper method to find tail
  def append(key, value)
    if @tail.nil?
      @tail = Node.new(key,value)
      @head = @tail
    else
      @tail.next_node = Node.new(key,value)
      @tail = temp
    end
  end
end
