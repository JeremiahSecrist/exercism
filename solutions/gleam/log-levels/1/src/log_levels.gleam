import gleam/string
pub fn message(log_line: String) -> String {
  case log_line {
    "[ERROR]:" <> message -> message |> string.trim()
    "[INFO]:" <> message -> message |> string.trim()
    "[WARNING]:" <> message -> message |> string.trim()
    _ -> log_line
  }
}

pub fn log_level(log_line: String) -> String {
    case log_line {
    "[ERROR]:" <> message -> "error"
    "[INFO]:" <> message -> "info"
    "[WARNING]:" <> message -> "warning"
    _ -> log_line
  }
}

pub fn reformat(log_line: String) -> String {
  message(log_line) <> " (" <> log_level(log_line) <> ")"
}
