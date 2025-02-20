///|
pub(all) enum Term {
  TmTrue(Info)
  TmFalse(Info)
  TmIf(Info, Term, Term, Term)
  TmZero(Info)
  TmSucc(Info, Term)
  TmPred(Info, Term)
  TmIsZero(Info, Term)
} derive(Show)

///|
pub(all) struct Info {
  loc_start : Pos
  loc_end : Pos
} derive(Show)

///|
pub(all) struct Pos {
  line : Int
  character : Int
} derive(Show)
