///|
pub fn eval(input : String) -> @interpreter.Value raise Error {
  let tokens = @lexer.tokenize(input)
  let term = @parser.expr(tokens)
  @interpreter.eval(term)
}
