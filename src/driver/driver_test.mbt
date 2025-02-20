///|
test "zero" {
  inspect!(eval?("zero"), content="Ok(Int(0))")
}

///|
test "true" {
  inspect!(eval?("true"), content="Ok(Bool(true))")
}

///|
test "succ zero" {
  inspect!(eval?("succ zero"), content="Ok(Int(1))")
}

///|
test "pred succ zero" {
  inspect!(eval?("pred succ zero"), content="Ok(Int(0))")
}

///|
test "if is_zero succ zero then succ zero else zero" {
  inspect!(
    eval?("if iszero succ zero then succ zero else zero"),
    content="Ok(Int(0))",
  )
}

///|
test {
  inspect!(
    eval?("0"),
    content="Err(UnrecognizedChar({line: 1, character: 0}, '0'))",
  )
}

///|
test {
  inspect!(
    eval?("if zero then true else false"),
    content="Err(TypeAssertFail(Int(0), IntType))",
  )
}
