pub fn is_leap_year(year: Int) -> Bool {
  case year {
    y if y % 400 == 0 -> True
    y if y % 100 == 0 -> False
    y if y % 4 == 0 -> True
    _ -> False
  }
}
