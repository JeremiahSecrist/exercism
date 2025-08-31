pub fn reply(guess: Int) -> String {
  case guess {
    42 -> "Correct"
    guess if guess == 41 || guess == 43 -> "So close"
    guess if guess > 43 -> "Too high"
    guess if guess < 41 -> "Too low"
    _ -> "Wrong"
  }
}
