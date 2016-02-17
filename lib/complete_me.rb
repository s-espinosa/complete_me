require 'pry'
require_relative 'node'

class CompleteMe
  attr_reader :root

  def initialize
    @root    = Node.new
    @number_of_words = 0
  end

  def insert(word, node = @root, index = 0)
    letters = word.split("")
    insert_letters(letters)
  end

  def insert_letters(letters, node = @root, index = 0)
    next_letter = letters[index]

    if next_letter == nil
      node.set_end_of_word
      @number_of_words += 1
    elsif node.pointer_hash[next_letter] == nil
      node.pointer_hash[next_letter] = Node.new
      index += 1
      insert_letters(letters, node.pointer_hash[next_letter], index)
    else
      index += 1
      insert_letters(letters, node.pointer_hash[next_letter], index)
    end
  end

  def count
    @number_of_words
  end

  def populate(words)
    word_array = words.split("\n")
    word_array.each do |word|
      insert(word)
    end
  end


  # def suggest(prefix)
  #   word_indices = translate_word_to_index_positions(prefix)
  #   base_node = find_node(word_indices)
  #
  #   suggestions = []
  #   suggestions = all_child_words(suggestions, base_node, prefix)
  #   suggestions
  #   # return an array of the potential words collected
  # end
  #
  # def all_child_words(suggestions, node, prefix)
  #   non_nil_children = node.pointer_array.select{|pointer| !pointer.nil?}
  #
  #   if non_nil_children == []
  #     suggestions << prefix
  #     #base case if all the items in the pointer_array are nil
  #     #push the word to the return_array
  #   elsif node.end_of_word == true
  #     prefix = prefix +
  #     suggestions << prefix
  #     non_nil_children.each do |child|
  #       all_child_words(suggestions, child, prefix)
  #     end
  #     #elsif the end_of_word flag is true
  #     #push the word to the return array
  #     #call all_child_words for each of the non-nil items in the pointer_array
  #   else
  #     non_nil_children.each do |child|
  #       all_child_words(suggestions, child, prefix)
  #     end
  #   end
  #   #else
  #   #call all_child_words for each of the non-nil items in the pointer_array
  # end
  #
  # def find_node(index_array, node = @root, index = 0)
  #   if index_array.length == index
  #     node
  #   else
  #     new_node = node.pointer_array[index_array[index]]
  #     index += 1
  #     find_node(index_array, new_node, index)
  #   end
  # end
  #
  #
  # def select
  #
  # end
end
