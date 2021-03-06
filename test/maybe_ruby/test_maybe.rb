require 'test_helper'

class TestMaybe < Minitest::Test


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


  def test_then_on_nothing
    assert_nil Maybe(nil).then(->(v) { v * 2 }).get
  end


  def test_then_with_no_lambda
    assert_equal Maybe(3)
      .then()
      .get, 3
  end


  def test_apply
    maybe_proc = Maybe(->(n) { n*n })

    assert_equal Maybe(3)
      .apply(maybe_proc)
      .get, 9
  end


  def test_apply_chained_with_then
    maybe_proc = Maybe(->(n) { n*n })

    assert_equal Maybe(3)
      .apply(maybe_proc)
      .then(->(n) { n-1 })
      .get, 8
  end


  def test_apply_with_no_proc
    maybe_proc = Maybe(12)

    assert_equal Maybe(3)
      .apply(maybe_proc)
      .get, 12
  end


  def test_apply_with_nil
    maybe_proc = Maybe(nil)

    assert_equal Maybe(3)
      .apply(maybe_proc)
      .get, nil
  end


  def test_apply_with_no_params
    assert_equal Maybe(3)
      .apply
      .get, nil
  end


  def test_apply_on_nothing
    maybe_proc = Maybe(->(n) { n*n })

    assert_equal Maybe(nil)
      .apply(maybe_proc)
      .get, nil
  end


  def test_apply_with_nil_and_or_else
    maybe_proc = Maybe(nil)

    assert_equal Maybe(3)
      .apply(maybe_proc)
      .or_else(666)
      .get, 666
  end


  def test_apply_complex_example
    assert_equal Maybe(3)
      .then(->(n) { n*n })
      .apply( Maybe(666).then(->(nb) { ->(nbb) { nb + nbb } }) )
      .get, 675
  end


  def test_done_1
    @errors = nil
    assert_equal Maybe(3)
      .then(->(int) { nil })
      .or_else(->() {
        @errors = "@First"
        "first error returned"
      })
      .then(->(int) { int - 5 })
      .then(->(int) { nil })
      .or_else(->() {
        @errors = "ok"
        "second error returned"
      })
      .get, "first error returned"

    assert_equal @errors, "@First"
  end


  def test_done_2
    @errors = nil
    assert_equal Maybe(3)
      .then(->(int) { int * 2 })
      .else(->() {
        @errors = "@first"
        "first error returned"
      })
      .or(->(int) { int - 5 })
      .then(->(int) { nil })
      .else(->() {
        @errors = "@second"
        "second error returned"
      })
      .get, "second error returned"

    assert_equal @errors, "@second"
  end


  def test_done_3
    @errors = nil
    assert_equal Maybe(3)
      .then(->(int) { int * 2 })
      .else(->() {
        @errors = "@first"
        "first error returned"
      })
      .or(->(int) { int - 5 })
      .then(->(int) { int - 1 })
      .else(->() {
        @errors = "@second"
        "second error returned"
      })
      .get, 0

    assert_equal @errors, nil
  end


  def test_bind
    assert_equal Maybe(3)
      .bind(->(x) { Maybe(2) })
      .get, 2
  end


  def test_bind_no_maybe
    assert_equal Maybe(3)
      .bind(->(x) { 2 })
      .get, 2
  end


  def test_bind_no_proc
    assert_equal Maybe(3)
      .bind(Maybe(2))
      .get, 3
  end


  def test_bind_proc_nil
    assert_equal Maybe(3)
      .bind(nil)
      .get, 3
  end


  def test_bind_nothing
    assert_equal Maybe(nil)
      .bind(->(x) { Maybe(2) })
      .get, nil
  end


  def test_bind_done
    assert_equal Maybe(nil)
      .else(3)
      .bind(->(x) { Maybe(2) })
      .get, 3
  end
end
