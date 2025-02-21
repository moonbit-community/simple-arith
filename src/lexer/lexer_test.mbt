///|
test {
  inspect!(
    tokenize?(
      #|if iszero 0 then
      #|  0
      #|else
      #|  succ 0
      #|
      ,
    ),
    content="Ok([(IF, {line: 1, character: 0}, {line: 1, character: 2}), (ISZERO, {line: 1, character: 3}, {line: 1, character: 9}), (ZERO, {line: 1, character: 10}, {line: 1, character: 11}), (THEN, {line: 1, character: 12}, {line: 1, character: 16}), (ZERO, {line: 2, character: 2}, {line: 2, character: 3}), (ELSE, {line: 3, character: 0}, {line: 3, character: 4}), (SUCC, {line: 4, character: 2}, {line: 4, character: 6}), (ZERO, {line: 4, character: 7}, {line: 4, character: 8})])",
  )
}
