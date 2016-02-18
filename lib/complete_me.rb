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

  def suggest(prefix)
    letter_array = prefix.chars
    starting_node = find_node(letter_array)

    potential_words = find_all_words(starting_node, letter_array)
    # all_words = potential_words.map do |word|
    #   prefix + word
    # end
  end

  def find_node(letter_array, node = @root, index = 0)
    if letter_array.length == index
      node
    else
      new_node = node.pointer_hash[letter_array[index]]
      index += 1
      find_node(letter_array, new_node, index)
    end
  end

  def find_all_words(node, prefix = [], words = [])
    # original_prefix = prefix.dup
    if node.end_of_word
      words << prefix.join
    else
      node.pointer_hash.each do |letter, letter_node|
        prefix << letter
        find_all_words(letter_node, prefix, words)
        # prefix = original_prefix
        prefix.pop
      end
    end
    words
  end

  # def select
  #
  # end
end

if __FILE__ == $0
  comp = CompleteMe.new
  comp.insert("pizza")
  comp.insert("pizzeria")
  comp.insert("piano")
  word_array = comp.find_all_words(comp.root)
  puts word_array.inspect
  puts comp.suggest("piz").inspect
end
