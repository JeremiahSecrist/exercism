import gleam/list.{range, fold}
import gleam/int.{absolute_value}

pub fn square_of_sum(n: Int) -> Int {
  let numbers = range(1, n)
  let sum = fold(numbers, 0, fn(acc, x) { acc + x })
  sum * sum
}
pub fn sum_of_squares(n: Int) -> Int {
    let numbers = range(1, n)
  let sum = fold(numbers, 0, fn(acc, x) { acc + {x * x} })
}

pub fn difference(n: Int) -> Int {
  sum_of_squares(n) - square_of_sum(n) |> absolute_value()
}
