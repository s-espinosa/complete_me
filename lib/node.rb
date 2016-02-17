class Node
  attr_reader :end_of_word, :pointer_hash

  def initialize
    @end_of_word = false
    @pointer_hash = {}
  end

  def set_end_of_word
    @end_of_word = true
  end
end
