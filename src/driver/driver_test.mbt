///|
test "0" {
  inspect(try? eval("0"), content="Ok(Int(0))")
}

///|
test "true" {
  inspect(try? eval("true"), content="Ok(Bool(true))")
}

///|
test "succ 0" {
  inspect(try? eval("succ 0"), content="Ok(Int(1))")
}

///|
test "pred (succ 0)" {
  inspect(try? eval("pred (succ 0)"), content="Ok(Int(0))")
}

///|
test "if is_zero (succ 0) then succ 0 else 0" {
  inspect(
    try? eval("if iszero (succ 0) then succ 0 else 0"),
    content="Ok(Int(0))",
  )
}

///|
test {
  inspect(
    try? eval("zero"),
    content="Err(UnrecognizedChar({line: 1, character: 0}, 'z'))",
  )
}

///|
test {
  inspect(
    try? eval("if 0 then true else false"),
    content="Err(TypeAssertFail(Int(0), IntType))",
  )
}
