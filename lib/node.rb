class Node
  attr_reader :end_of_word, :pointer_array

  def initialize
    @end_of_word = false
    @pointer_array = []
    26.times do @pointer_array.push(nil) end
  end

  def set_end_of_word
    @end_of_word = true
  end
end
