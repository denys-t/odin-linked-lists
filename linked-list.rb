class LinkedList
  attr_reader :size, :head, :tail

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    new_node = Node.new(value)
    
    if @size.zero?
      @head = new_node
    else
      @tail.next_node = new_node
    end

    @tail = new_node
    @size += 1
  end

  def prepend(value)
    new_node = Node.new(value)

    if @size.zero?
      @tail = new_node
    else
      new_node.next_node = @head
    end

    @head = new_node
    @size += 1
  end

  def at(index)
    raise StandardError.new('Index out of range') if index >= @size
    
    curr_node = @head
    (0..index).each do |i|
      return curr_node if i == index

      curr_node = curr_node.next_node
      i += 1
    end
  end

  def pop
    return if @size.zero?

    curr_node = @head
    (0..@size - 2).each do |i|
      if i == @size - 2
        curr_node.next_node = nil
        @tail = curr_node
      end

      curr_node = curr_node.next_node
    end

    @size -= 1
  end

  def contains?(value)
    node = @head
    loop do
      if node.value == value
        return true
      elsif node == @tail
        return false
      end

      node = node.next_node
    end
  end

  def find(value)
    curr_node = @head
    (0..@size - 1).each do |index|
      return index if curr_node.value == value

      curr_node = curr_node.next_node
    end

    return nil
  end

  def to_s
    return '' if @size.zero?

    nodes_str = ''
    curr_node = @head

    loop do
      nodes_str += ' -> ' if nodes_str[-1] == ')'
      nodes_str += "( #{curr_node.value} )"

      if curr_node == @tail
        nodes_str += ' -> nil'
        break
      else
        curr_node = curr_node.next_node
      end
    end

    return nodes_str
  end

  def insert_at(value, index)
    raise StandardError.new('Index out of range') if index > @size

    if index.zero?
      self.prepend(value)
      return
    elsif index == @size - 1
      self.append(value)
      return
    end

    curr_node = @head
    (0..index - 1).each do |i|
      if i == index - 1
        new_node = Node.new(value, curr_node.next_node)
        curr_node.next_node = new_node
        @size += 1
        break
      end

      curr_node = curr_node.next_node
    end
  end

  def remove_at(index)
    raise StandardError.new('Index out of range') if index >= @size

    if index.zero?
      @head = @head.next_node
      @size -= 1
      return
    elsif index == @size - 1
      self.pop
      return
    end

    curr_node = @head
    (0..index - 1).each do |i|
      if i == index - 1
        curr_node.next_node = curr_node.next_node.next_node
        @size -= 1
        break
      end

      curr_node = curr_node.next_node
    end
  end
end

class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end
