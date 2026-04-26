///|
pub impl Show for Term with output(self, logger) {
  match self {
    TmTrue(info) => {
      logger.write_string("TmTrue(")
      logger.write_object(info)
      logger.write_string(")")
    }
    TmFalse(info) => {
      logger.write_string("TmFalse(")
      logger.write_object(info)
      logger.write_string(")")
    }
    TmIf(info, pred, if_true, if_false) => {
      logger.write_string("TmIf(")
      logger.write_object(info)
      logger.write_string(", ")
      logger.write_object(pred)
      logger.write_string(", ")
      logger.write_object(if_true)
      logger.write_string(", ")
      logger.write_object(if_false)
      logger.write_string(")")
    }
    TmZero(info) => {
      logger.write_string("TmZero(")
      logger.write_object(info)
      logger.write_string(")")
    }
    TmSucc(info, term) => {
      logger.write_string("TmSucc(")
      logger.write_object(info)
      logger.write_string(", ")
      logger.write_object(term)
      logger.write_string(")")
    }
    TmPred(info, term) => {
      logger.write_string("TmPred(")
      logger.write_object(info)
      logger.write_string(", ")
      logger.write_object(term)
      logger.write_string(")")
    }
    TmIsZero(info, term) => {
      logger.write_string("TmIsZero(")
      logger.write_object(info)
      logger.write_string(", ")
      logger.write_object(term)
      logger.write_string(")")
    }
  }
}

///|
pub impl Show for Info with output(self, logger) {
  logger.write_string("{loc_start: ")
  logger.write_object(self.loc_start)
  logger.write_string(", loc_end: ")
  logger.write_object(self.loc_end)
  logger.write_string("}")
}

///|
pub impl Show for Pos with output(self, logger) {
  logger.write_string("{line: ")
  logger.write_object(self.line)
  logger.write_string(", character: ")
  logger.write_object(self.character)
  logger.write_string("}")
}
