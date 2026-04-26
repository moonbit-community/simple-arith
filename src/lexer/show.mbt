///|
pub impl Show for LexError with output(self, logger) {
  match self {
    UnrecognizedChar(pos, char) => {
      logger.write_string("UnrecognizedChar(")
      logger.write_object(pos)
      logger.write_string(", ")
      logger.write_object(char)
      logger.write_string(")")
    }
  }
}
