require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/complete_me.rb'

class CompleteMeTest < Minitest::Test
  def test_it_can_initialize_without_any_parameters
    complete = CompleteMe.new

    assert complete.is_a?(Object)
  end

  def test_it_can_insert_single_words
    comp = CompleteMe.new
    comp.insert("babe")

    assert comp.root
    refute comp.root.pointer_array[1].nil?
    b = comp.root.pointer_array[1]

    refute b.pointer_array[0].nil?
    a = b.pointer_array[0]

    refute a.pointer_array[1].nil?
    b = a.pointer_array[1]

    refute b.pointer_array[4].nil?
    e = b.pointer_array[4]

    assert e.end_of_word
  end

  def test_it_can_count_the_number_of_words_inserted
    comp = CompleteMe.new
    comp.insert("babe")
    comp.insert("pizza")
    comp.insert("piano")

    assert_equal 3, comp.count
  end

  def test_it_suggests_potential_words_given_a_prefix
    skip
    comp = CompleteMe.new
    comp.insert("pizza")
    actual = comp.suggest("piz")

    assert_equal "pizza", actual
  end

  def test_it_populates_with_words_given_dictionary_input
    comp = CompleteMe.new
    dictionary = File.read('/usr/share/dict/words')

    comp.populate(dictionary)

    assert_equal 235886, comp.count
  end

  def test_it_translates_words_to_indices
    complete = CompleteMe.new

    actual = complete.translate_word_to_index_positions("baby")
    expected = [1, 0, 1, 24]
    assert_equal expected, actual
  end

end
