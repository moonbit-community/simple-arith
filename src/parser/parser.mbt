pub(all) typealias Position = @syntax.Pos

pub(all) enum Token {
  TRUE
  FALSE
  IF
  THEN
  ELSE
  ZERO
  SUCC
  PRED
  ISZERO
} derive(Show)

pub fn Token::kind(self : Token) -> TokenKind {
  match self {
    TRUE => TK_TRUE
    FALSE => TK_FALSE
    IF => TK_IF
    THEN => TK_THEN
    ELSE => TK_ELSE
    ZERO => TK_ZERO
    SUCC => TK_SUCC
    PRED => TK_PRED
    ISZERO => TK_ISZERO
  }
}

pub(all) enum TokenKind {
  TK_TRUE
  TK_FALSE
  TK_IF
  TK_THEN
  TK_ELSE
  TK_ZERO
  TK_SUCC
  TK_PRED
  TK_ISZERO
}

pub impl Show for TokenKind with output(self, logger) {
  logger.write_string(
    match self {
      TK_TRUE => "TRUE"
      TK_FALSE => "FALSE"
      TK_IF => "IF"
      TK_THEN => "THEN"
      TK_ELSE => "ELSE"
      TK_ZERO => "ZERO"
      TK_SUCC => "SUCC"
      TK_PRED => "PRED"
      TK_ISZERO => "ISZERO"
    }
  )
}

pub type! ParseError {
  UnexpectedToken(Token, (Position, Position), Array[TokenKind])
  UnexpectedEndOfInput(Position, Array[TokenKind])
}

typealias YYObj = Error

priv type! YYObj_Void

priv type! YYObj__syntax_Term @syntax.Term

typealias YYState = (YYSymbol) -> YYDecision

typealias YYAction = (Position, ArrayView[(YYObj, Position, Position)]) -> YYObj

priv enum YYDecision {
  Accept
  Shift(YYState)
  Reduce(Int, YYSymbol, YYAction)
  ReduceNoLookahead(Int, YYSymbol, YYAction)
  Error
}

priv enum YYSymbol {
  T_TRUE
  T_FALSE
  T_IF
  T_THEN
  T_ELSE
  T_ZERO
  T_SUCC
  T_PRED
  T_ISZERO
  NT_expr
  NT_arith_expr
  NT_atom_expr
  EOI
}

// Workaround for EOI unused warning
fn init {
  match EOI {
    EOI => ()
    _ => ()
  }
}

fn yy_action_0(_last_pos : Position, _args : ArrayView[(YYObj, Position, Position)]) -> YYObj {
  guard let YYObj__syntax_Term(_dollar1) = _args[0].0
  YYObj__syntax_Term({();  _dollar1 })
}

fn yy_action_1(_last_pos : Position, _args : ArrayView[(YYObj, Position, Position)]) -> YYObj {
  guard let YYObj__syntax_Term(e1) = _args[1].0
  guard let YYObj__syntax_Term(e2) = _args[3].0
  guard let YYObj__syntax_Term(e3) = _args[5].0
  let _start_pos = _args[0].1
  let _end_pos = _args[5].2
  YYObj__syntax_Term({();  TmIf({loc_start: _start_pos, loc_end: _end_pos}, e1, e2, e3) })
}

fn yy_action_2(_last_pos : Position, _args : ArrayView[(YYObj, Position, Position)]) -> YYObj {
  guard let YYObj__syntax_Term(_dollar1) = _args[0].0
  YYObj__syntax_Term({();  _dollar1 })
}

fn yy_action_3(_last_pos : Position, _args : ArrayView[(YYObj, Position, Position)]) -> YYObj {
  guard let YYObj__syntax_Term(e1) = _args[1].0
  let _start_pos = _args[0].1
  let _end_pos = _args[1].2
  YYObj__syntax_Term({();  TmSucc({loc_start: _start_pos, loc_end: _end_pos}, e1) })
}

fn yy_action_4(_last_pos : Position, _args : ArrayView[(YYObj, Position, Position)]) -> YYObj {
  guard let YYObj__syntax_Term(e1) = _args[1].0
  let _start_pos = _args[0].1
  let _end_pos = _args[1].2
  YYObj__syntax_Term({();  TmPred({loc_start: _start_pos, loc_end: _end_pos}, e1) })
}

fn yy_action_5(_last_pos : Position, _args : ArrayView[(YYObj, Position, Position)]) -> YYObj {
  guard let YYObj__syntax_Term(e1) = _args[1].0
  let _start_pos = _args[0].1
  let _end_pos = _args[1].2
  YYObj__syntax_Term({();  TmIsZero({loc_start: _start_pos, loc_end: _end_pos}, e1) })
}

fn yy_action_6(_last_pos : Position, _args : ArrayView[(YYObj, Position, Position)]) -> YYObj {
  let _start_pos = _args[0].1
  let _end_pos = _args[0].2
  YYObj__syntax_Term({();  TmZero({loc_start: _start_pos, loc_end: _end_pos}) })
}

fn yy_action_7(_last_pos : Position, _args : ArrayView[(YYObj, Position, Position)]) -> YYObj {
  let _start_pos = _args[0].1
  let _end_pos = _args[0].2
  YYObj__syntax_Term({();  TmTrue({loc_start: _start_pos, loc_end: _end_pos}) })
}

fn yy_action_8(_last_pos : Position, _args : ArrayView[(YYObj, Position, Position)]) -> YYObj {
  let _start_pos = _args[0].1
  let _end_pos = _args[0].2
  YYObj__syntax_Term({();  TmFalse({loc_start: _start_pos, loc_end: _end_pos}) })
}

fn yy_input(token : Token, _start_pos : Position, _end_pos : Position) -> (YYSymbol, YYObj) {
  match token {
    TRUE => (T_TRUE, YYObj_Void)
    FALSE => (T_FALSE, YYObj_Void)
    IF => (T_IF, YYObj_Void)
    THEN => (T_THEN, YYObj_Void)
    ELSE => (T_ELSE, YYObj_Void)
    ZERO => (T_ZERO, YYObj_Void)
    SUCC => (T_SUCC, YYObj_Void)
    PRED => (T_PRED, YYObj_Void)
    ISZERO => (T_ISZERO, YYObj_Void)
  }
}

// [0, expr → • arith_expr, $]
// [1, expr → • IF expr THEN expr ELSE expr, $]
// [2, arith_expr → • atom_expr, $]
// [3, arith_expr → • SUCC arith_expr, $]
// [4, arith_expr → • PRED arith_expr, $]
// [5, arith_expr → • ISZERO arith_expr, $]
// [6, atom_expr → • ZERO, $]
// [7, atom_expr → • TRUE, $]
// [8, atom_expr → • FALSE, $]
// [9, expr_prime → • expr, $]
fn yy_state_0(_lookahead : YYSymbol) -> YYDecision {
  match _lookahead {
    NT_expr => Shift(yy_state_1)
    T_FALSE => Shift(yy_state_2)
    T_TRUE => Shift(yy_state_3)
    T_ZERO => Shift(yy_state_4)
    T_ISZERO => Shift(yy_state_5)
    T_PRED => Shift(yy_state_7)
    T_SUCC => Shift(yy_state_9)
    NT_atom_expr => Shift(yy_state_11)
    T_IF => Shift(yy_state_12)
    NT_arith_expr => Shift(yy_state_18)
    _ => Error
  }
}

// [9, expr_prime → expr •, $]
fn yy_state_1(_lookahead : YYSymbol) -> YYDecision {
  Accept
}

// [8, atom_expr → FALSE •, $ / THEN / ELSE]
fn yy_state_2(_lookahead : YYSymbol) -> YYDecision {
  ReduceNoLookahead(1, NT_atom_expr, yy_action_8)
}

// [7, atom_expr → TRUE •, $ / THEN / ELSE]
fn yy_state_3(_lookahead : YYSymbol) -> YYDecision {
  ReduceNoLookahead(1, NT_atom_expr, yy_action_7)
}

// [6, atom_expr → ZERO •, $ / THEN / ELSE]
fn yy_state_4(_lookahead : YYSymbol) -> YYDecision {
  ReduceNoLookahead(1, NT_atom_expr, yy_action_6)
}

// [2, arith_expr → • atom_expr, $ / THEN / ELSE]
// [3, arith_expr → • SUCC arith_expr, $ / THEN / ELSE]
// [4, arith_expr → • PRED arith_expr, $ / THEN / ELSE]
// [5, arith_expr → • ISZERO arith_expr, $ / THEN / ELSE]
// [5, arith_expr → ISZERO • arith_expr, $ / THEN / ELSE]
// [6, atom_expr → • ZERO, $ / THEN / ELSE]
// [7, atom_expr → • TRUE, $ / THEN / ELSE]
// [8, atom_expr → • FALSE, $ / THEN / ELSE]
fn yy_state_5(_lookahead : YYSymbol) -> YYDecision {
  match _lookahead {
    T_FALSE => Shift(yy_state_2)
    T_TRUE => Shift(yy_state_3)
    T_ZERO => Shift(yy_state_4)
    T_ISZERO => Shift(yy_state_5)
    NT_arith_expr => Shift(yy_state_6)
    T_PRED => Shift(yy_state_7)
    T_SUCC => Shift(yy_state_9)
    NT_atom_expr => Shift(yy_state_11)
    _ => Error
  }
}

// [5, arith_expr → ISZERO arith_expr •, $ / THEN / ELSE]
fn yy_state_6(_lookahead : YYSymbol) -> YYDecision {
  ReduceNoLookahead(2, NT_arith_expr, yy_action_5)
}

// [2, arith_expr → • atom_expr, $ / THEN / ELSE]
// [3, arith_expr → • SUCC arith_expr, $ / THEN / ELSE]
// [4, arith_expr → • PRED arith_expr, $ / THEN / ELSE]
// [4, arith_expr → PRED • arith_expr, $ / THEN / ELSE]
// [5, arith_expr → • ISZERO arith_expr, $ / THEN / ELSE]
// [6, atom_expr → • ZERO, $ / THEN / ELSE]
// [7, atom_expr → • TRUE, $ / THEN / ELSE]
// [8, atom_expr → • FALSE, $ / THEN / ELSE]
fn yy_state_7(_lookahead : YYSymbol) -> YYDecision {
  match _lookahead {
    T_FALSE => Shift(yy_state_2)
    T_TRUE => Shift(yy_state_3)
    T_ZERO => Shift(yy_state_4)
    T_ISZERO => Shift(yy_state_5)
    T_PRED => Shift(yy_state_7)
    NT_arith_expr => Shift(yy_state_8)
    T_SUCC => Shift(yy_state_9)
    NT_atom_expr => Shift(yy_state_11)
    _ => Error
  }
}

// [4, arith_expr → PRED arith_expr •, $ / THEN / ELSE]
fn yy_state_8(_lookahead : YYSymbol) -> YYDecision {
  ReduceNoLookahead(2, NT_arith_expr, yy_action_4)
}

// [2, arith_expr → • atom_expr, $ / THEN / ELSE]
// [3, arith_expr → • SUCC arith_expr, $ / THEN / ELSE]
// [3, arith_expr → SUCC • arith_expr, $ / THEN / ELSE]
// [4, arith_expr → • PRED arith_expr, $ / THEN / ELSE]
// [5, arith_expr → • ISZERO arith_expr, $ / THEN / ELSE]
// [6, atom_expr → • ZERO, $ / THEN / ELSE]
// [7, atom_expr → • TRUE, $ / THEN / ELSE]
// [8, atom_expr → • FALSE, $ / THEN / ELSE]
fn yy_state_9(_lookahead : YYSymbol) -> YYDecision {
  match _lookahead {
    T_FALSE => Shift(yy_state_2)
    T_TRUE => Shift(yy_state_3)
    T_ZERO => Shift(yy_state_4)
    T_ISZERO => Shift(yy_state_5)
    T_PRED => Shift(yy_state_7)
    T_SUCC => Shift(yy_state_9)
    NT_arith_expr => Shift(yy_state_10)
    NT_atom_expr => Shift(yy_state_11)
    _ => Error
  }
}

// [3, arith_expr → SUCC arith_expr •, $ / THEN / ELSE]
fn yy_state_10(_lookahead : YYSymbol) -> YYDecision {
  ReduceNoLookahead(2, NT_arith_expr, yy_action_3)
}

// [2, arith_expr → atom_expr •, $ / THEN / ELSE]
fn yy_state_11(_lookahead : YYSymbol) -> YYDecision {
  ReduceNoLookahead(1, NT_arith_expr, yy_action_2)
}

// [0, expr → • arith_expr, THEN]
// [1, expr → • IF expr THEN expr ELSE expr, THEN]
// [1, expr → IF • expr THEN expr ELSE expr, $ / THEN / ELSE]
// [2, arith_expr → • atom_expr, THEN]
// [3, arith_expr → • SUCC arith_expr, THEN]
// [4, arith_expr → • PRED arith_expr, THEN]
// [5, arith_expr → • ISZERO arith_expr, THEN]
// [6, atom_expr → • ZERO, THEN]
// [7, atom_expr → • TRUE, THEN]
// [8, atom_expr → • FALSE, THEN]
fn yy_state_12(_lookahead : YYSymbol) -> YYDecision {
  match _lookahead {
    T_FALSE => Shift(yy_state_2)
    T_TRUE => Shift(yy_state_3)
    T_ZERO => Shift(yy_state_4)
    T_ISZERO => Shift(yy_state_5)
    T_PRED => Shift(yy_state_7)
    T_SUCC => Shift(yy_state_9)
    NT_atom_expr => Shift(yy_state_11)
    T_IF => Shift(yy_state_12)
    NT_expr => Shift(yy_state_13)
    NT_arith_expr => Shift(yy_state_18)
    _ => Error
  }
}

// [1, expr → IF expr • THEN expr ELSE expr, $ / THEN / ELSE]
fn yy_state_13(_lookahead : YYSymbol) -> YYDecision {
  match _lookahead {
    T_THEN => Shift(yy_state_14)
    _ => Error
  }
}

// [0, expr → • arith_expr, ELSE]
// [1, expr → • IF expr THEN expr ELSE expr, ELSE]
// [1, expr → IF expr THEN • expr ELSE expr, $ / THEN / ELSE]
// [2, arith_expr → • atom_expr, ELSE]
// [3, arith_expr → • SUCC arith_expr, ELSE]
// [4, arith_expr → • PRED arith_expr, ELSE]
// [5, arith_expr → • ISZERO arith_expr, ELSE]
// [6, atom_expr → • ZERO, ELSE]
// [7, atom_expr → • TRUE, ELSE]
// [8, atom_expr → • FALSE, ELSE]
fn yy_state_14(_lookahead : YYSymbol) -> YYDecision {
  match _lookahead {
    T_FALSE => Shift(yy_state_2)
    T_TRUE => Shift(yy_state_3)
    T_ZERO => Shift(yy_state_4)
    T_ISZERO => Shift(yy_state_5)
    T_PRED => Shift(yy_state_7)
    T_SUCC => Shift(yy_state_9)
    NT_atom_expr => Shift(yy_state_11)
    T_IF => Shift(yy_state_12)
    NT_expr => Shift(yy_state_15)
    NT_arith_expr => Shift(yy_state_18)
    _ => Error
  }
}

// [1, expr → IF expr THEN expr • ELSE expr, $ / THEN / ELSE]
fn yy_state_15(_lookahead : YYSymbol) -> YYDecision {
  match _lookahead {
    T_ELSE => Shift(yy_state_16)
    _ => Error
  }
}

// [0, expr → • arith_expr, $ / THEN / ELSE]
// [1, expr → • IF expr THEN expr ELSE expr, $ / THEN / ELSE]
// [1, expr → IF expr THEN expr ELSE • expr, $ / THEN / ELSE]
// [2, arith_expr → • atom_expr, $ / THEN / ELSE]
// [3, arith_expr → • SUCC arith_expr, $ / THEN / ELSE]
// [4, arith_expr → • PRED arith_expr, $ / THEN / ELSE]
// [5, arith_expr → • ISZERO arith_expr, $ / THEN / ELSE]
// [6, atom_expr → • ZERO, $ / THEN / ELSE]
// [7, atom_expr → • TRUE, $ / THEN / ELSE]
// [8, atom_expr → • FALSE, $ / THEN / ELSE]
fn yy_state_16(_lookahead : YYSymbol) -> YYDecision {
  match _lookahead {
    T_FALSE => Shift(yy_state_2)
    T_TRUE => Shift(yy_state_3)
    T_ZERO => Shift(yy_state_4)
    T_ISZERO => Shift(yy_state_5)
    T_PRED => Shift(yy_state_7)
    T_SUCC => Shift(yy_state_9)
    NT_atom_expr => Shift(yy_state_11)
    T_IF => Shift(yy_state_12)
    NT_expr => Shift(yy_state_17)
    NT_arith_expr => Shift(yy_state_18)
    _ => Error
  }
}

// [1, expr → IF expr THEN expr ELSE expr •, $ / THEN / ELSE]
fn yy_state_17(_lookahead : YYSymbol) -> YYDecision {
  ReduceNoLookahead(6, NT_expr, yy_action_1)
}

// [0, expr → arith_expr •, $ / THEN / ELSE]
fn yy_state_18(_lookahead : YYSymbol) -> YYDecision {
  ReduceNoLookahead(1, NT_expr, yy_action_0)
}

fn yy_parse[T](
  tokens : Array[(Token, Position, Position)],
  start : YYState,
  return_ : (YYObj) -> T,
  initial_pos? : Position,
) -> T!ParseError {
  let mut cursor = 0
  let mut state_stack : @immut/list.T[YYState] = Cons(start, Nil)
  let data_stack : Array[(YYObj, Position, Position)] = []
  let mut last_pos = initial_pos.or(tokens[0].1)
  let mut state = start
  let mut lookahead : Option[(YYSymbol, (YYObj, Position, Position), Token?)] = None
  let mut last_shifted_state_stack = state_stack
  while true {
    let decision = match state(EOI) {
      ReduceNoLookahead(_) | Accept as t => t
      _ => {
        match lookahead {
          Some(la) => state(la.0)
          None => {
            if cursor < tokens.length() {
              let (token, start_pos, end_pos) = tokens[cursor]
              cursor += 1
              let (symbol, data) = yy_input(token, start_pos, end_pos)
              lookahead = Some((symbol, (data, start_pos, end_pos), Some(token)))
              state(symbol)
            } else {
              lookahead = Some((EOI, (YYObj_Void, last_pos, last_pos), None))
              state(EOI)
            }
          }
        }
      }
    }
    match decision {
      Accept => return return_(data_stack.unsafe_pop().0)
      Shift(next_state) => {
        guard let Some(la) = lookahead
        data_stack.push(la.1)
        state_stack = Cons(next_state, state_stack)
        last_shifted_state_stack = state_stack
        state = next_state
        last_pos = la.1.2
        lookahead = None
      }
      Reduce(count, symbol, action)
      | ReduceNoLookahead(count, symbol, action) => {
        loop (count, symbol, action) {
          _ => {
            let args = data_stack[data_stack.length() - count:]
            let data = action(last_pos, args)
            let (start_pos, end_pos) = if args.length() == 0 {
              (last_pos, last_pos)
            } else {
              (args[0].1, args[args.length() - 1].2)
            }
            for i in 0..<count {
              ignore(data_stack.unsafe_pop())
              state_stack = state_stack.tail()
            }
            state = state_stack.unsafe_head()
            data_stack.push((data, start_pos, end_pos))
            match state(symbol) {
              Accept => return return_(data_stack.unsafe_pop().0)
              Shift(next_state) => {
                state_stack = Cons(next_state, state_stack)
                state = next_state
              }
              Reduce(count, symbol, action)
              | ReduceNoLookahead(count, symbol, action) => continue (count, symbol, action)
              _ => panic()
            }
          }
        }
      }
      Error => {
        let (_, (_, start_pos, end_pos), token) = lookahead.unwrap()
        error!(last_shifted_state_stack, token, (start_pos, end_pos))
      }
    }
  }
  panic()
}

fn error(stack : @immut/list.T[YYState], token : Token?, loc : (Position, Position)) -> Unit!ParseError {
  let expected = []
  fn try_add(symbol : YYSymbol, kind : TokenKind) {
    fn go(stack : @immut/list.T[YYState]) {
      match stack {
        Nil => ()
        Cons(state, _) => {
          match state(symbol) {
            Accept | Shift(_) => expected.push(kind)
            Reduce(count, symbol, _) | ReduceNoLookahead(count, symbol, _) => {
              fn inner_go(stack : @immut/list.T[YYState], count, symbol) {
                let stack = stack.drop(count)
                guard let Cons(state, _) = stack
                match state(symbol) {
                  Shift(state) => go(Cons(state, stack))
                  Reduce(count, symbol, _) | ReduceNoLookahead(count, symbol, _) => inner_go(stack, count, symbol)
                  _ => panic()
                }
              }
              inner_go(stack, count, symbol)
            }
            Error => ()
          }
        }
      }
    }
    go(stack)
  }
  for term in ([(T_TRUE, TK_TRUE), (T_FALSE, TK_FALSE), (T_IF, TK_IF), (T_THEN, TK_THEN), (T_ELSE, TK_ELSE), (T_ZERO, TK_ZERO), (T_SUCC, TK_SUCC), (T_PRED, TK_PRED), (T_ISZERO, TK_ISZERO)] : Array[(YYSymbol, TokenKind)]) {
    try_add(term.0, term.1)
  }
  match token {
    None => raise UnexpectedEndOfInput(loc.1, expected)
    Some(token) => raise UnexpectedToken(token, loc, expected)
  }
}

pub fn expr(tokens : Array[(Token, Position, Position)], initial_pos? : Position) -> @syntax.Term!ParseError {
  yy_parse!(
    tokens,
    yy_state_0,
    fn {
      YYObj__syntax_Term(result) => result
      _ => panic()
    },
    initial_pos?,
  )
}
