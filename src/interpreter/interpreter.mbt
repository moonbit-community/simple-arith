///|
pub suberror EvalError {
  TypeAssertFail(Value, Type)
} derive(Show)

///|
pub(all) enum Type {
  BoolType
  IntType
} derive(Show)

///|
pub(all) enum Value {
  Bool(Bool)
  Int(Int)
} derive(Show)

///|
pub fn eval(term : @syntax.Term) -> Value raise EvalError {
  match term {
    TmPred(_, e1) => {
      let v1 = eval(e1).assert_int()
      Int(v1 - 1)
    }
    TmSucc(_, e1) => {
      let v1 = eval(e1).assert_int()
      Int(v1 + 1)
    }
    TmZero(_) => Int(0)
    TmIf(_, pred, e1, e2) =>
      if eval(pred).assert_bool() {
        eval(e1)
      } else {
        eval(e2)
      }
    TmTrue(_) => Bool(true)
    TmFalse(_) => Bool(false)
    TmIsZero(_, e1) => {
      let v1 = eval(e1).assert_int()
      if v1 == 0 {
        Bool(true)
      } else {
        Bool(false)
      }
    }
  }
}

///|
fn assert_bool(self : Value) -> Bool raise EvalError {
  match self {
    Bool(value) => value
    Int(_) => raise TypeAssertFail(self, IntType)
  }
}

///|
fn assert_int(self : Value) -> Int raise EvalError {
  match self {
    Int(value) => value
    Bool(_) => raise TypeAssertFail(self, BoolType)
  }
}
