require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/node.rb'

class CompleteMeTest < Minitest::Test
  def test_it_can_initialize_without_any_parameters
    node = Node.new
    assert node.is_a?(Object)
  end

  def test_it_initializes_with_an_empty_hash
    node = Node.new
    expected = {}
    actual   = node.pointer_hash

    assert_equal expected, actual
  end

  def test_when_initialized_it_is_not_the_end_of_a_word
    node = Node.new

    assert_equal false, node.end_of_word
  end

end
