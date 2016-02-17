require 'pry'
require_relative 'node'

class CompleteMe
  attr_reader :root

  def initialize
    @letters =* ("a".."z")
    @root    = Node.new
  end

  def insert(word, node = @root, index = 0)
    letters_as_numbers = translate_word_to_index_positions(word.downcase)
    insert_letters(letters_as_numbers)
  end

  def count
    counter = 0
    counter = count_recursively(@root, counter)
    counter
  end

  def count_recursively(node, counter)
    node.pointer_array.each do |letter|
      if !letter.nil? && letter.end_of_word == true
        counter += 1
        counter = count_recursively(letter, counter)
      elsif !letter.nil?
        counter = count_recursively(letter, counter)
      end
    end
    counter
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

  def translate_word_to_index_positions(word)
    word = word.split("")
    index_array = word.map do |letter|
      @letters.index(letter)
    end
  end

  def insert_letters(letters_as_numbers, node = @root, index = 0)
    next_letter = letters_as_numbers[index]

    if next_letter == nil
      node.set_end_of_word
    elsif node.pointer_array[next_letter] == nil
      node.pointer_array[next_letter] = Node.new
      index += 1
      insert_letters(letters_as_numbers, node.pointer_array[next_letter], index)
    else
      index += 1
      insert_letters(letters_as_numbers, node.pointer_array[next_letter], index)
    end
  end
end
