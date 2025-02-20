///|
test {
  inspect!(
    tokenize?(
      #|if iszero zero then
      #|  zero
      #|else
      #|  succ zero
      #|
      ,
    ),
    content="Ok([(IF, {line: 1, character: 0}, {line: 1, character: 2}), (ISZERO, {line: 1, character: 3}, {line: 1, character: 9}), (ZERO, {line: 1, character: 10}, {line: 1, character: 14}), (THEN, {line: 1, character: 15}, {line: 1, character: 19}), (ZERO, {line: 2, character: 2}, {line: 2, character: 6}), (ELSE, {line: 3, character: 0}, {line: 3, character: 4}), (SUCC, {line: 4, character: 2}, {line: 4, character: 6}), (ZERO, {line: 4, character: 7}, {line: 4, character: 11})])",
  )
}
