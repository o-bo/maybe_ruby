require 'test_helper'

class TestMaybeRuby < Minitest::Test


  def setup
  end


  def test_that_it_has_a_version_number
    refute_nil ::MaybeRuby::VERSION
  end


  def test_maybe_for_simple_int
    assert_equal Maybe(3).or_else(12).get, 3
  end


  def test_maybe_for_nil
    assert_equal Maybe(nil).or_else(12).get, 12
  end


  def test_maybe_for_simple_array
    assert_equal Maybe([3,2,1]).or_else("Empty array").get, [3,2,1]
  end


  def test_maybe_for_empty_array
    assert_equal Maybe([]).or_else("Empty array").get, []
  end


  def test_maybe_for_nil_value
    assert_equal Maybe(nil).or_else("Nil Value").get, "Nil Value"
  end


  def test_then_with_simple_int
    assert_equal Maybe(3).then(->(int) { int * 2 }).get, 6
  end


  def test_chain_then
    assert_equal Maybe(3)
      .then(->(int) { int * 2 })
      .then(->(int) { int - 5 })
      .get, 1
  end


  def test_chain_then_with_nil_and_side_effects
    @errors = nil
    assert_equal Maybe(3)
      .then(->(int) { int * 2 })
      .then(->(int) { int - 5 })
      .then(->(int) { nil })
      .or_else(->() {
        @errors = "ok"
        "error returned"
      })
      .get, "error returned"

      assert_equal @errors, "ok"
  end


  def test_then_on_nothing
    assert_nil Maybe(nil).then(->(v) { v * 2 }).get
  end


  def test_then_with_no_lambda
    assert_equal Maybe(3)
      .then()
      .get, 3
  end
end
