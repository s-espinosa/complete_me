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
    refute comp.root.pointer_hash["b"].nil?
    b = comp.root.pointer_hash["b"]

    refute b.pointer_hash["a"].nil?
    a = b.pointer_hash["a"]

    refute a.pointer_hash["b"].nil?
    b = a.pointer_hash["b"]

    refute b.pointer_hash["e"].nil?
    e = b.pointer_hash["e"]

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
    assert_equal 235886, comp.alt_count    
  end
end
