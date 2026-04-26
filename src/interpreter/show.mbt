///|
pub impl Show for EvalError with output(self, logger) {
  match self {
    TypeAssertFail(value, type_) => {
      logger.write_string("TypeAssertFail(")
      logger.write_object(value)
      logger.write_string(", ")
      logger.write_object(type_)
      logger.write_string(")")
    }
  }
}

///|
pub impl Show for Type with output(self, logger) {
  logger.write_string(
    match self {
      BoolType => "BoolType"
      IntType => "IntType"
    },
  )
}

///|
pub impl Show for Value with output(self, logger) {
  match self {
    Bool(value) => {
      logger.write_string("Bool(")
      logger.write_object(value)
      logger.write_string(")")
    }
    Int(value) => {
      logger.write_string("Int(")
      logger.write_object(value)
      logger.write_string(")")
    }
  }
}
