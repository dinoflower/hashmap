# frozen_string_literal: true

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
    @head = Node.new(key, value)
  end

  def append(key, value)
    find_tail.next_node = Node.new(key, value)
  end

  def prepend(key, value)
    temp = Node.new(key, value)
    temp.next_node = @head unless @head.nil?

    @head = temp
  end

  def contains?(key, node = @head)
    return true if node.key == key

    return false if tail?(node)

    contains?(key, node.next_node)
  end

  def find(key, node = @head)
    return nil if node.nil?

    each_node { |node| return node if yield(node) } if block_given?

    return node if node.key == key

    find(key, node.next_node)
  end

  # verbose
  def delete(key)
    if @head.key == key
      output = @head
      @head = @head.next_node
    else
      parent_node = find(key) { |node| node.next_node.key == key }
      output = parent_node.next_node
      parent_node.next_node = output.next_node
    end
    output
  end

  def each_node
    node = @head
    until node.nil?
      yield node
      node = node.next_node
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
end
