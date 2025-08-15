
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
  LPAREN
  RPAREN
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
    LPAREN => TK_LPAREN
    RPAREN => TK_RPAREN
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
  TK_LPAREN
  TK_RPAREN
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
      TK_LPAREN => "LPAREN"
      TK_RPAREN => "RPAREN"
    }
  )
}

pub suberror ParseError {
  UnexpectedToken(Token, (@syntax.Pos, @syntax.Pos), Array[TokenKind])
  UnexpectedEndOfInput(@syntax.Pos, Array[TokenKind])
}

typealias Error as YYObj

priv suberror YYObj_Void

priv suberror YYObj__syntax_Term @syntax.Term

typealias (YYSymbol) -> YYDecision as YYState

typealias (@syntax.Pos, ArrayView[(YYObj, @syntax.Pos, @syntax.Pos)]) -> YYObj as YYAction

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
  T_LPAREN
  T_RPAREN
  NT_expr
  NT_arith_expr
  NT_atom_expr
  EOI
}

// Workaround for EOI unused warning
fn init {
  match (EOI : YYSymbol) {
    EOI => ()
    _ => ()
  }
}

// file:///./parser.mbty
// 37|    LPAREN expr RPAREN                    { $2 }
fn yy_action_0(_last_pos : @syntax.Pos, _args : ArrayView[(YYObj, @syntax.Pos, @syntax.Pos)]) -> YYObj {
  guard _args[1].0 is YYObj__syntax_Term(_dollar2)
  YYObj__syntax_Term({();  _dollar2 })
}

// file:///./parser.mbty
// 27|    atom_expr                             { $1 }
fn yy_action_1(_last_pos : @syntax.Pos, _args : ArrayView[(YYObj, @syntax.Pos, @syntax.Pos)]) -> YYObj {
  guard _args[0].0 is YYObj__syntax_Term(_dollar1)
  YYObj__syntax_Term({();  _dollar1 })
}

// file:///./parser.mbty
// 28|    SUCC e1=arith_expr                    { TmSucc({loc_start: $startpos, loc_end: $endpos}, e1) }
fn yy_action_2(_last_pos : @syntax.Pos, _args : ArrayView[(YYObj, @syntax.Pos, @syntax.Pos)]) -> YYObj {
  guard _args[1].0 is YYObj__syntax_Term(e1)
  let _start_pos = if _args.length() == 0 { _last_pos } else { _args[0].1 }
  let _end_pos = if _args.length() == 0 { _last_pos } else { _args[_args.length() - 1].2 }
  YYObj__syntax_Term({();  TmSucc({loc_start: _start_pos, loc_end: _end_pos}, e1) })
}

// file:///./parser.mbty
// 22|    arith_expr                            { $1 }
fn yy_action_3(_last_pos : @syntax.Pos, _args : ArrayView[(YYObj, @syntax.Pos, @syntax.Pos)]) -> YYObj {
  guard _args[0].0 is YYObj__syntax_Term(_dollar1)
  YYObj__syntax_Term({();  _dollar1 })
}

// file:///./parser.mbty
// 36|    FALSE                                 { TmFalse({loc_start: $startpos, loc_end: $endpos}) }
fn yy_action_4(_last_pos : @syntax.Pos, _args : ArrayView[(YYObj, @syntax.Pos, @syntax.Pos)]) -> YYObj {
  let _start_pos = if _args.length() == 0 { _last_pos } else { _args[0].1 }
  let _end_pos = if _args.length() == 0 { _last_pos } else { _args[_args.length() - 1].2 }
  YYObj__syntax_Term({();  TmFalse({loc_start: _start_pos, loc_end: _end_pos}) })
}

// file:///./parser.mbty
// 35|    TRUE                                  { TmTrue({loc_start: $startpos, loc_end: $endpos}) }
fn yy_action_5(_last_pos : @syntax.Pos, _args : ArrayView[(YYObj, @syntax.Pos, @syntax.Pos)]) -> YYObj {
  let _start_pos = if _args.length() == 0 { _last_pos } else { _args[0].1 }
  let _end_pos = if _args.length() == 0 { _last_pos } else { _args[_args.length() - 1].2 }
  YYObj__syntax_Term({();  TmTrue({loc_start: _start_pos, loc_end: _end_pos}) })
}

// file:///./parser.mbty
// 30|    ISZERO e1=arith_expr                  { TmIsZero({loc_start: $startpos, loc_end: $endpos}, e1) }
fn yy_action_6(_last_pos : @syntax.Pos, _args : ArrayView[(YYObj, @syntax.Pos, @syntax.Pos)]) -> YYObj {
  guard _args[1].0 is YYObj__syntax_Term(e1)
  let _start_pos = if _args.length() == 0 { _last_pos } else { _args[0].1 }
  let _end_pos = if _args.length() == 0 { _last_pos } else { _args[_args.length() - 1].2 }
  YYObj__syntax_Term({();  TmIsZero({loc_start: _start_pos, loc_end: _end_pos}, e1) })
}

// file:///./parser.mbty
// 34|    ZERO                                  { TmZero({loc_start: $startpos, loc_end: $endpos}) }
fn yy_action_7(_last_pos : @syntax.Pos, _args : ArrayView[(YYObj, @syntax.Pos, @syntax.Pos)]) -> YYObj {
  let _start_pos = if _args.length() == 0 { _last_pos } else { _args[0].1 }
  let _end_pos = if _args.length() == 0 { _last_pos } else { _args[_args.length() - 1].2 }
  YYObj__syntax_Term({();  TmZero({loc_start: _start_pos, loc_end: _end_pos}) })
}

// file:///./parser.mbty
// 29|    PRED e1=arith_expr                    { TmPred({loc_start: $startpos, loc_end: $endpos}, e1) }
fn yy_action_8(_last_pos : @syntax.Pos, _args : ArrayView[(YYObj, @syntax.Pos, @syntax.Pos)]) -> YYObj {
  guard _args[1].0 is YYObj__syntax_Term(e1)
  let _start_pos = if _args.length() == 0 { _last_pos } else { _args[0].1 }
  let _end_pos = if _args.length() == 0 { _last_pos } else { _args[_args.length() - 1].2 }
  YYObj__syntax_Term({();  TmPred({loc_start: _start_pos, loc_end: _end_pos}, e1) })
}

// file:///./parser.mbty
// 23|    IF e1=expr THEN e2=expr ELSE e3=expr  { TmIf({loc_start: $startpos, loc_end: $endpos}, e1, e2, e3) }
fn yy_action_9(_last_pos : @syntax.Pos, _args : ArrayView[(YYObj, @syntax.Pos, @syntax.Pos)]) -> YYObj {
  guard _args[1].0 is YYObj__syntax_Term(e1)
  guard _args[3].0 is YYObj__syntax_Term(e2)
  guard _args[5].0 is YYObj__syntax_Term(e3)
  let _start_pos = if _args.length() == 0 { _last_pos } else { _args[0].1 }
  let _end_pos = if _args.length() == 0 { _last_pos } else { _args[_args.length() - 1].2 }
  YYObj__syntax_Term({();  TmIf({loc_start: _start_pos, loc_end: _end_pos}, e1, e2, e3) })
}

fn yy_input(token : Token, _start_pos : @syntax.Pos, _end_pos : @syntax.Pos) -> (YYSymbol, YYObj) {
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
    LPAREN => (T_LPAREN, YYObj_Void)
    RPAREN => (T_RPAREN, YYObj_Void)
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
// [9, atom_expr → • LPAREN expr RPAREN, $]
// [10, expr_prime → • expr, $]
fn yy_state_0(_lookahead : YYSymbol) -> YYDecision {
  match _lookahead {
    NT_expr => Shift(yy_state_1)
    T_LPAREN => Shift(yy_state_2)
    T_FALSE => Shift(yy_state_5)
    T_TRUE => Shift(yy_state_6)
    T_ZERO => Shift(yy_state_7)
    T_ISZERO => Shift(yy_state_8)
    T_PRED => Shift(yy_state_10)
    T_SUCC => Shift(yy_state_12)
    NT_atom_expr => Shift(yy_state_14)
    T_IF => Shift(yy_state_15)
    NT_arith_expr => Shift(yy_state_21)
    _ => Error
  }
}

// [10, expr_prime → expr •, $]
fn yy_state_1(_lookahead : YYSymbol) -> YYDecision {
  Accept
}

// [0, expr → • arith_expr, RPAREN]
// [1, expr → • IF expr THEN expr ELSE expr, RPAREN]
// [2, arith_expr → • atom_expr, RPAREN]
// [3, arith_expr → • SUCC arith_expr, RPAREN]
// [4, arith_expr → • PRED arith_expr, RPAREN]
// [5, arith_expr → • ISZERO arith_expr, RPAREN]
// [6, atom_expr → • ZERO, RPAREN]
// [7, atom_expr → • TRUE, RPAREN]
// [8, atom_expr → • FALSE, RPAREN]
// [9, atom_expr → • LPAREN expr RPAREN, RPAREN]
// [9, atom_expr → LPAREN • expr RPAREN, $ / THEN / ELSE / RPAREN]
fn yy_state_2(_lookahead : YYSymbol) -> YYDecision {
  match _lookahead {
    T_LPAREN => Shift(yy_state_2)
    NT_expr => Shift(yy_state_3)
    T_FALSE => Shift(yy_state_5)
    T_TRUE => Shift(yy_state_6)
    T_ZERO => Shift(yy_state_7)
    T_ISZERO => Shift(yy_state_8)
    T_PRED => Shift(yy_state_10)
    T_SUCC => Shift(yy_state_12)
    NT_atom_expr => Shift(yy_state_14)
    T_IF => Shift(yy_state_15)
    NT_arith_expr => Shift(yy_state_21)
    _ => Error
  }
}

// [9, atom_expr → LPAREN expr • RPAREN, $ / THEN / ELSE / RPAREN]
fn yy_state_3(_lookahead : YYSymbol) -> YYDecision {
  match _lookahead {
    T_RPAREN => Shift(yy_state_4)
    _ => Error
  }
}

// [9, atom_expr → LPAREN expr RPAREN •, $ / THEN / ELSE / RPAREN]
fn yy_state_4(_lookahead : YYSymbol) -> YYDecision {
  ReduceNoLookahead(3, NT_atom_expr, yy_action_0)
}

// [8, atom_expr → FALSE •, $ / THEN / ELSE / RPAREN]
fn yy_state_5(_lookahead : YYSymbol) -> YYDecision {
  ReduceNoLookahead(1, NT_atom_expr, yy_action_4)
}

// [7, atom_expr → TRUE •, $ / THEN / ELSE / RPAREN]
fn yy_state_6(_lookahead : YYSymbol) -> YYDecision {
  ReduceNoLookahead(1, NT_atom_expr, yy_action_5)
}

// [6, atom_expr → ZERO •, $ / THEN / ELSE / RPAREN]
fn yy_state_7(_lookahead : YYSymbol) -> YYDecision {
  ReduceNoLookahead(1, NT_atom_expr, yy_action_7)
}

// [2, arith_expr → • atom_expr, $ / THEN / ELSE / RPAREN]
// [3, arith_expr → • SUCC arith_expr, $ / THEN / ELSE / RPAREN]
// [4, arith_expr → • PRED arith_expr, $ / THEN / ELSE / RPAREN]
// [5, arith_expr → • ISZERO arith_expr, $ / THEN / ELSE / RPAREN]
// [5, arith_expr → ISZERO • arith_expr, $ / THEN / ELSE / RPAREN]
// [6, atom_expr → • ZERO, $ / THEN / ELSE / RPAREN]
// [7, atom_expr → • TRUE, $ / THEN / ELSE / RPAREN]
// [8, atom_expr → • FALSE, $ / THEN / ELSE / RPAREN]
// [9, atom_expr → • LPAREN expr RPAREN, $ / THEN / ELSE / RPAREN]
fn yy_state_8(_lookahead : YYSymbol) -> YYDecision {
  match _lookahead {
    T_LPAREN => Shift(yy_state_2)
    T_FALSE => Shift(yy_state_5)
    T_TRUE => Shift(yy_state_6)
    T_ZERO => Shift(yy_state_7)
    T_ISZERO => Shift(yy_state_8)
    NT_arith_expr => Shift(yy_state_9)
    T_PRED => Shift(yy_state_10)
    T_SUCC => Shift(yy_state_12)
    NT_atom_expr => Shift(yy_state_14)
    _ => Error
  }
}

// [5, arith_expr → ISZERO arith_expr •, $ / THEN / ELSE / RPAREN]
fn yy_state_9(_lookahead : YYSymbol) -> YYDecision {
  ReduceNoLookahead(2, NT_arith_expr, yy_action_6)
}

// [2, arith_expr → • atom_expr, $ / THEN / ELSE / RPAREN]
// [3, arith_expr → • SUCC arith_expr, $ / THEN / ELSE / RPAREN]
// [4, arith_expr → • PRED arith_expr, $ / THEN / ELSE / RPAREN]
// [4, arith_expr → PRED • arith_expr, $ / THEN / ELSE / RPAREN]
// [5, arith_expr → • ISZERO arith_expr, $ / THEN / ELSE / RPAREN]
// [6, atom_expr → • ZERO, $ / THEN / ELSE / RPAREN]
// [7, atom_expr → • TRUE, $ / THEN / ELSE / RPAREN]
// [8, atom_expr → • FALSE, $ / THEN / ELSE / RPAREN]
// [9, atom_expr → • LPAREN expr RPAREN, $ / THEN / ELSE / RPAREN]
fn yy_state_10(_lookahead : YYSymbol) -> YYDecision {
  match _lookahead {
    T_LPAREN => Shift(yy_state_2)
    T_FALSE => Shift(yy_state_5)
    T_TRUE => Shift(yy_state_6)
    T_ZERO => Shift(yy_state_7)
    T_ISZERO => Shift(yy_state_8)
    T_PRED => Shift(yy_state_10)
    NT_arith_expr => Shift(yy_state_11)
    T_SUCC => Shift(yy_state_12)
    NT_atom_expr => Shift(yy_state_14)
    _ => Error
  }
}

// [4, arith_expr → PRED arith_expr •, $ / THEN / ELSE / RPAREN]
fn yy_state_11(_lookahead : YYSymbol) -> YYDecision {
  ReduceNoLookahead(2, NT_arith_expr, yy_action_8)
}

// [2, arith_expr → • atom_expr, $ / THEN / ELSE / RPAREN]
// [3, arith_expr → • SUCC arith_expr, $ / THEN / ELSE / RPAREN]
// [3, arith_expr → SUCC • arith_expr, $ / THEN / ELSE / RPAREN]
// [4, arith_expr → • PRED arith_expr, $ / THEN / ELSE / RPAREN]
// [5, arith_expr → • ISZERO arith_expr, $ / THEN / ELSE / RPAREN]
// [6, atom_expr → • ZERO, $ / THEN / ELSE / RPAREN]
// [7, atom_expr → • TRUE, $ / THEN / ELSE / RPAREN]
// [8, atom_expr → • FALSE, $ / THEN / ELSE / RPAREN]
// [9, atom_expr → • LPAREN expr RPAREN, $ / THEN / ELSE / RPAREN]
fn yy_state_12(_lookahead : YYSymbol) -> YYDecision {
  match _lookahead {
    T_LPAREN => Shift(yy_state_2)
    T_FALSE => Shift(yy_state_5)
    T_TRUE => Shift(yy_state_6)
    T_ZERO => Shift(yy_state_7)
    T_ISZERO => Shift(yy_state_8)
    T_PRED => Shift(yy_state_10)
    T_SUCC => Shift(yy_state_12)
    NT_arith_expr => Shift(yy_state_13)
    NT_atom_expr => Shift(yy_state_14)
    _ => Error
  }
}

// [3, arith_expr → SUCC arith_expr •, $ / THEN / ELSE / RPAREN]
fn yy_state_13(_lookahead : YYSymbol) -> YYDecision {
  ReduceNoLookahead(2, NT_arith_expr, yy_action_2)
}

// [2, arith_expr → atom_expr •, $ / THEN / ELSE / RPAREN]
fn yy_state_14(_lookahead : YYSymbol) -> YYDecision {
  ReduceNoLookahead(1, NT_arith_expr, yy_action_1)
}

// [0, expr → • arith_expr, THEN]
// [1, expr → • IF expr THEN expr ELSE expr, THEN]
// [1, expr → IF • expr THEN expr ELSE expr, $ / THEN / ELSE / RPAREN]
// [2, arith_expr → • atom_expr, THEN]
// [3, arith_expr → • SUCC arith_expr, THEN]
// [4, arith_expr → • PRED arith_expr, THEN]
// [5, arith_expr → • ISZERO arith_expr, THEN]
// [6, atom_expr → • ZERO, THEN]
// [7, atom_expr → • TRUE, THEN]
// [8, atom_expr → • FALSE, THEN]
// [9, atom_expr → • LPAREN expr RPAREN, THEN]
fn yy_state_15(_lookahead : YYSymbol) -> YYDecision {
  match _lookahead {
    T_LPAREN => Shift(yy_state_2)
    T_FALSE => Shift(yy_state_5)
    T_TRUE => Shift(yy_state_6)
    T_ZERO => Shift(yy_state_7)
    T_ISZERO => Shift(yy_state_8)
    T_PRED => Shift(yy_state_10)
    T_SUCC => Shift(yy_state_12)
    NT_atom_expr => Shift(yy_state_14)
    T_IF => Shift(yy_state_15)
    NT_expr => Shift(yy_state_16)
    NT_arith_expr => Shift(yy_state_21)
    _ => Error
  }
}

// [1, expr → IF expr • THEN expr ELSE expr, $ / THEN / ELSE / RPAREN]
fn yy_state_16(_lookahead : YYSymbol) -> YYDecision {
  match _lookahead {
    T_THEN => Shift(yy_state_17)
    _ => Error
  }
}

// [0, expr → • arith_expr, ELSE]
// [1, expr → • IF expr THEN expr ELSE expr, ELSE]
// [1, expr → IF expr THEN • expr ELSE expr, $ / THEN / ELSE / RPAREN]
// [2, arith_expr → • atom_expr, ELSE]
// [3, arith_expr → • SUCC arith_expr, ELSE]
// [4, arith_expr → • PRED arith_expr, ELSE]
// [5, arith_expr → • ISZERO arith_expr, ELSE]
// [6, atom_expr → • ZERO, ELSE]
// [7, atom_expr → • TRUE, ELSE]
// [8, atom_expr → • FALSE, ELSE]
// [9, atom_expr → • LPAREN expr RPAREN, ELSE]
fn yy_state_17(_lookahead : YYSymbol) -> YYDecision {
  match _lookahead {
    T_LPAREN => Shift(yy_state_2)
    T_FALSE => Shift(yy_state_5)
    T_TRUE => Shift(yy_state_6)
    T_ZERO => Shift(yy_state_7)
    T_ISZERO => Shift(yy_state_8)
    T_PRED => Shift(yy_state_10)
    T_SUCC => Shift(yy_state_12)
    NT_atom_expr => Shift(yy_state_14)
    T_IF => Shift(yy_state_15)
    NT_expr => Shift(yy_state_18)
    NT_arith_expr => Shift(yy_state_21)
    _ => Error
  }
}

// [1, expr → IF expr THEN expr • ELSE expr, $ / THEN / ELSE / RPAREN]
fn yy_state_18(_lookahead : YYSymbol) -> YYDecision {
  match _lookahead {
    T_ELSE => Shift(yy_state_19)
    _ => Error
  }
}

// [0, expr → • arith_expr, $ / THEN / ELSE / RPAREN]
// [1, expr → • IF expr THEN expr ELSE expr, $ / THEN / ELSE / RPAREN]
// [1, expr → IF expr THEN expr ELSE • expr, $ / THEN / ELSE / RPAREN]
// [2, arith_expr → • atom_expr, $ / THEN / ELSE / RPAREN]
// [3, arith_expr → • SUCC arith_expr, $ / THEN / ELSE / RPAREN]
// [4, arith_expr → • PRED arith_expr, $ / THEN / ELSE / RPAREN]
// [5, arith_expr → • ISZERO arith_expr, $ / THEN / ELSE / RPAREN]
// [6, atom_expr → • ZERO, $ / THEN / ELSE / RPAREN]
// [7, atom_expr → • TRUE, $ / THEN / ELSE / RPAREN]
// [8, atom_expr → • FALSE, $ / THEN / ELSE / RPAREN]
// [9, atom_expr → • LPAREN expr RPAREN, $ / THEN / ELSE / RPAREN]
fn yy_state_19(_lookahead : YYSymbol) -> YYDecision {
  match _lookahead {
    T_LPAREN => Shift(yy_state_2)
    T_FALSE => Shift(yy_state_5)
    T_TRUE => Shift(yy_state_6)
    T_ZERO => Shift(yy_state_7)
    T_ISZERO => Shift(yy_state_8)
    T_PRED => Shift(yy_state_10)
    T_SUCC => Shift(yy_state_12)
    NT_atom_expr => Shift(yy_state_14)
    T_IF => Shift(yy_state_15)
    NT_expr => Shift(yy_state_20)
    NT_arith_expr => Shift(yy_state_21)
    _ => Error
  }
}

// [1, expr → IF expr THEN expr ELSE expr •, $ / THEN / ELSE / RPAREN]
fn yy_state_20(_lookahead : YYSymbol) -> YYDecision {
  ReduceNoLookahead(6, NT_expr, yy_action_9)
}

// [0, expr → arith_expr •, $ / THEN / ELSE / RPAREN]
fn yy_state_21(_lookahead : YYSymbol) -> YYDecision {
  ReduceNoLookahead(1, NT_expr, yy_action_3)
}

fn[T] yy_parse(
  tokens : Array[(Token, @syntax.Pos, @syntax.Pos)],
  start : YYState,
  return_ : (YYObj) -> T,
  initial_pos? : @syntax.Pos,
) -> T raise ParseError {
  let mut cursor = 0
  let mut state_stack : @list.List[YYState] = @list.construct(start, @list.empty())
  let data_stack : Array[(YYObj, @syntax.Pos, @syntax.Pos)] = []
  let mut last_pos = initial_pos.unwrap_or(tokens[0].1)
  let mut state = start
  let mut lookahead : Option[(YYSymbol, (YYObj, @syntax.Pos, @syntax.Pos), Token?)] = None
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
        guard lookahead is Some(la)
        data_stack.push(la.1)
        state_stack = @list.construct(next_state, state_stack)
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
              state_stack = state_stack.unsafe_tail()
            }
            state = state_stack.unsafe_head()
            data_stack.push((data, start_pos, end_pos))
            match state(symbol) {
              Accept => return return_(data_stack.unsafe_pop().0)
              Shift(next_state) => {
                state_stack = @list.construct(next_state, state_stack)
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
        error(last_shifted_state_stack, token, (start_pos, end_pos))
      }
    }
  }
  panic()
}

fn error(stack : @list.List[YYState], token : Token?, loc : (@syntax.Pos, @syntax.Pos)) -> Unit raise ParseError {
  let expected = []
  fn try_add(symbol : YYSymbol, kind : TokenKind) {
    fn go(stack : @list.List[YYState]) {
      match stack {
        Empty => ()
        More(state, ..) => {
          match state(symbol) {
            Accept | Shift(_) => expected.push(kind)
            Reduce(count, symbol, _) | ReduceNoLookahead(count, symbol, _) => {
              fn inner_go(stack : @list.List[YYState], count, symbol) {
                let stack = stack.drop(count)
                guard stack is More(state, ..)
                match state(symbol) {
                  Shift(state) => go(@list.construct(state, stack))
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
  for term in ([(T_TRUE, TK_TRUE), (T_FALSE, TK_FALSE), (T_IF, TK_IF), (T_THEN, TK_THEN), (T_ELSE, TK_ELSE), (T_ZERO, TK_ZERO), (T_SUCC, TK_SUCC), (T_PRED, TK_PRED), (T_ISZERO, TK_ISZERO), (T_LPAREN, TK_LPAREN), (T_RPAREN, TK_RPAREN)] : Array[(YYSymbol, TokenKind)]) {
    try_add(term.0, term.1)
  }
  match token {
    None => raise UnexpectedEndOfInput(loc.1, expected)
    Some(token) => raise UnexpectedToken(token, loc, expected)
  }
}

pub fn expr(tokens : Array[(Token, @syntax.Pos, @syntax.Pos)], initial_pos? : @syntax.Pos) -> @syntax.Term raise ParseError {
  yy_parse(
    tokens,
    yy_state_0,
    (it) => {
      guard it is YYObj__syntax_Term(result)
      result
    },
    initial_pos?,
  )
}
