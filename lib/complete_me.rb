require 'pry'
require_relative 'node'

class CompleteMe
  attr_reader :root

  def initialize
    @letters =* ("a".."z")
    @root    = Node.new
  end

  def insert(word, node = @root, index = 0)
    letters_as_numbers = translate_word_to_index_positions(word)
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

  # def count
  #
  # end
  #
  #
  # def suggest(prefix)
  #
  # end
  #
  # def populate(words)
  #
  # end
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
