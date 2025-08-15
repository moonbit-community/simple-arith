///|
test {
  inspect(
    try? eval(
      TmIf(
        {
          loc_start: { line: 1, character: 0 },
          loc_end: { line: 4, character: 11 },
        },
        TmIsZero(
          {
            loc_start: { line: 1, character: 3 },
            loc_end: { line: 1, character: 14 },
          },
          TmZero({
            loc_start: { line: 1, character: 10 },
            loc_end: { line: 1, character: 14 },
          }),
        ),
        TmZero({
          loc_start: { line: 2, character: 2 },
          loc_end: { line: 2, character: 6 },
        }),
        TmSucc(
          {
            loc_start: { line: 4, character: 2 },
            loc_end: { line: 4, character: 11 },
          },
          TmZero({
            loc_start: { line: 4, character: 7 },
            loc_end: { line: 4, character: 11 },
          }),
        ),
      ),
    ),
    content="Ok(Int(0))",
  )
}
