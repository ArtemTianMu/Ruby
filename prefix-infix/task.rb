class Node
  attr_accessor :value, :right, :left

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

end

def return_node(string, node)
  string = string + " "
  elements = Array.new
  index_start = 0
  index_length = 0

  (0..string.length).each do |i|
    if is_operator(string[i]) == nil
      index_length += 1
    else
      current_element = string[index_start,index_length]
      elements.append(current_element)
      elements.append(string[i,1])
      index_start = i+1
      index_length = 0
    end
  end

  elements.pop

  current_element = 0
  for element in elements
    if element.match(/NODE./) != nil
      index_node = element[4,element.length-4].to_i
      elements.delete_at(current_element)
      elements.insert(current_element,node[index_node])
    end
    current_element+=1
  end



  while elements.length > 1
    if elements.find_index("^") != nil
      index = elements.find_index("^")
    elsif elements.find_index("*") != nil
      index = elements.find_index("*")
    elsif elements.find_index("/") != nil
      index = elements.find_index("/")
    elsif elements.find_index("+") != nil
      index = elements.find_index("+")
    elsif elements.find_index("-") != nil
      index = elements.find_index("-")
    end
    if elements[index-1].instance_of?(Node)
      param_left = elements[index-1]
    else
      param_left = Node.new(elements[index-1])
    end

    if elements[index+1].instance_of?(Node)
      param_right = elements[index+1]
    else
      param_right = Node.new(elements[index+1])
    end

    root = Node.new(elements[index])
    root.left = param_left
    root.right = param_right

    elements.delete_at(index-1)
    elements.delete_at(index-1)
    elements.delete_at(index-1)

    elements.insert(index-1,root)
  end
  elements[0]
end


def main

  node_array = Array.new

  node = nil

  puts "Enter your expression: "

  string = gets.chomp.to_s

  index_start = 0
  index_stop = 0

  node_index = 0

  while has_brackets(string) != nil
  (0..string.length).each do |i|
    if string[i] == "("
      index_start = i
    elsif string[i] == ")"
      index_stop = i
      break
    else
      next
    end
  end

  node_array.append(return_node(string[index_start+1,index_stop-index_start-1],node_array))
  (0..(index_stop-index_start)).each do |_|
    string.slice!(index_start)
  end

  string.insert(index_start,"NODE"+node_index.to_s)
  node_index += 1
  end

  node = return_node(string,node_array)

  result = preorder(node)

  result = trim_brackets(result)

  puts "Prefix order: "
  puts result


end

def trim_brackets(string)
  amount = string.scan(/\(\w\){1,1}/).count
  while amount != 0 do
    index = string.index(/\(\w\){1,1}/)
    string[index] = ""
    string[index+1] = ""
    amount-=1
  end
  string
end


def preorder(tree)
  string = ""
  if tree != nil
    string += '(' + tree.value.to_s
    string +=  preorder(tree.left)
    string +=  preorder(tree.right)+')'
  end
  string
end


def has_brackets(string)
  string =~ /[\(\)]/
end

def has_node(string)
  string =~ /NODE./
end


def is_operator(string)
  string =~ /[^a-zA-Z0-9]/
end

main
