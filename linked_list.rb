class LinkedList
  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    temp = create_node(value)
    temp.index = @size - 1
    if @tail.nil?
      @tail = temp
      @head = @tail
    else
      @tail.next_node = temp
      @tail = temp
    end
  end
end
