// Please define the TreasureChest generic custom type
pub type TreasureChest(a) {
  TreasureChest(String, a)
}
// Please define the UnlockResult generic custom type
pub type UnlockResult(a) {
  Unlocked(a)
  WrongPassword
}

pub fn get_treasure(
  chest: TreasureChest(a),
  attempt: String,
) -> UnlockResult(a) {
  case chest {
    TreasureChest(password, treasure) ->
      case attempt == password {
        True -> Unlocked(treasure)
        False -> WrongPassword
      }
  }
}
