///|
pub impl Show for Token with output(self, logger) {
  logger.write_string(
    match self {
      TRUE => "TRUE"
      FALSE => "FALSE"
      IF => "IF"
      THEN => "THEN"
      ELSE => "ELSE"
      ZERO => "ZERO"
      SUCC => "SUCC"
      PRED => "PRED"
      ISZERO => "ISZERO"
      LPAREN => "LPAREN"
      RPAREN => "RPAREN"
    },
  )
}
