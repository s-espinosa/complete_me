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
    skip
  end

  def test_it_can_count_the_number_of_words_inserted
    skip
  end

  def test_it_has_a_head_with_all_letters_as_children
    skip
  end

  def test_it_translates_words_to_indices
    complete = CompleteMe.new

    actual = complete.translate_word_to_index_positions("baby")
    expected = [1, 0, 1, 24]
    assert_equal expected, actual
  end

end
