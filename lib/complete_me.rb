require 'pry'
require_relative 'node'

class CompleteMe
  attr_reader :root

  def initialize
    @root    = Node.new
    @number_of_words = 0
    @recommendations = {}
  end

  def insert(word)
    letters = word.split("")
    insert_letters(letters)
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
    suggested_words = check_suggested(potential_words, prefix)
  end

  def check_suggested(potential_words, prefix)
    if @recommendations.keys.include?(prefix)
      suggested_words = sort_suggested(potential_words, prefix)
    else
      suggested_words = potential_words
    end
    suggested_words
  end

  def sort_suggested(potential_words, prefix)
    recommended_words = @recommendations[prefix]

    sorted_recommendation_hash = recommended_words.sort_by{ |word, score| score }.reverse

    suggested_array = sorted_recommendation_hash.map{ |word, score| word }

    potential_words.each do |word|
      suggested_array.push(word) if !suggested_array.include?(word)
    end

    suggested_array
  end

  def select(prefix, word)
    if @recommendations[prefix] && @recommendations[prefix][word]
      @recommendations[prefix][word] += 1
    elsif !@recommendations[prefix]
      @recommendations[prefix] = {word => 1}
    else
      @recommendations[prefix][word] = 1
    end
  end

  private

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
    words << prefix.join if node.end_of_word
    node.pointer_hash.each do |letter, letter_node|
      prefix << letter
      find_all_words(letter_node, prefix, words)
      prefix.pop
    end
    words
  end
end
