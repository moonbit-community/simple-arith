
///|
struct Lexbuf {
   content : String
   mut pos : Int
 }

///|
pub fn Lexbuf::from_string(content : String) -> Lexbuf {
   { content, pos: 0 }
 }

// NOTE: MoonBit do have unboxed Option[Char] optimization
///|
fn next(self : Lexbuf) -> Char? {
   if self.pos < self.content.length() {
     let ch = self.content[self.pos]
     self.pos += 1
     Some(ch)
   } else {
     None
   }
 }

///|
fn substring(self : Lexbuf, start : Int, end : Int) -> String {
   self.content.substring(start~, end~)
 }

///|
typealias LexTagAction = Array[Array[Int]]

///|
typealias LexState = Int

///|
typealias LexInput = Int

///|
pub(all) struct LexEngine {
   graph : Array[(LexState) -> (LexState, LexTagAction)]
   end_nodes : Array[(Int, Array[((Int, Int), (Int, Int))])?]
   start_tags : Array[Int]
   code_blocks_n : Int
 }

///|
pub fn run(self : LexEngine, lexbuf : Lexbuf) -> (Int, Array[(Int, Int)]) {
   let mut state = 1
   let mut tagState : Array[Array[Int]] = []
   let backtrace = Array::make(self.code_blocks_n, None)
   for tag in self.start_tags {
     while tagState.length() <= tag {
       tagState.push([])
     }
     tagState[tag].push(lexbuf.pos)
   }
   while state != 0 {
     match self.end_nodes[state] {
       Some(t) => backtrace[t.0] = Some((lexbuf.pos, state, tagState))
       _ => ()
     }
     let b = match lexbuf.next() {
       Some(b) => b
       None => '\x00'
     }
     let next = self.graph[state](b.to_int())
     state = next.0
     let new_tagState : Array[Array[Int]] = []
     for i = 0; i < next.1.length(); i = i + 1 {
       new_tagState.push([])
       for j = 0; j < next.1[i].length(); j = j + 1 {
         let t = next.1[i][j]
         if t == -1 {
           new_tagState[i].push(lexbuf.pos)
         } else {
           new_tagState[i].push(tagState[i][t])
         }
       }
     }
     tagState = new_tagState
   }
   for index, b in backtrace {
     match b {
       Some((p, state, tagState)) => {
         lexbuf.pos = p
         let captures = self.end_nodes[state].unwrap().1.map(
           fn {
             ((b_t, b_r), (e_t, e_r)) => (tagState[b_t][b_r], tagState[e_t][e_r])
           },
         )
         break (index, captures)
       }
       None => ()
     }
   } else {
     (self.code_blocks_n, [])
   }
 }



priv type! EndOfFile
pub type! LexError {
   UnrecognizedChar(@syntax.Pos, Char)
 } derive(Show)

struct LineTrackingContext {
   mut line: Int
   mut line_start: Int
 }

fn new_line(self : LineTrackingContext, pos: Int) -> Unit {
   self.line += 1
   self.line_start = pos
 }

fn pos(self : LineTrackingContext, pos: Int) -> @syntax.Pos {
   { line: self.line, character: pos - self.line_start }
 }


let token_tag_action_row_0 : Array[Int] = []
let token_tag_action_row_2 : Array[Int] = [-1]
let token_tag_action_row_1 : Array[Int] = [0]
let token_tag_action_row_3 : Array[Int] = [-1, 0]

let token_tag_action_0 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0]
let token_tag_action_1 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_2]
let token_tag_action_17 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0]
let token_tag_action_5 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_2]
let token_tag_action_26 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_2, token_tag_action_row_0, token_tag_action_row_0]
let token_tag_action_19 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0]
let token_tag_action_24 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_2, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0]
let token_tag_action_16 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0]
let token_tag_action_27 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_2, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0]
let token_tag_action_12 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0]
let token_tag_action_7 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_2]
let token_tag_action_21 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_2, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0]
let token_tag_action_11 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0]
let token_tag_action_8 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_2]
let token_tag_action_20 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_2, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0]
let token_tag_action_13 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0]
let token_tag_action_10 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_2]
let token_tag_action_22 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_2, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0]
let token_tag_action_14 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0]
let token_tag_action_4 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_2]
let token_tag_action_23 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_2, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0]
let token_tag_action_18 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0]
let token_tag_action_9 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_2]
let token_tag_action_25 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_2, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0]
let token_tag_action_6 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_2]
let token_tag_action_15 : Array[Array[Int]] = [token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_2, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0]
let token_tag_action_2 : Array[Array[Int]] = [token_tag_action_row_2, token_tag_action_row_0, token_tag_action_row_2, token_tag_action_row_0, token_tag_action_row_2, token_tag_action_row_0, token_tag_action_row_2, token_tag_action_row_0, token_tag_action_row_2, token_tag_action_row_0, token_tag_action_row_2, token_tag_action_row_0, token_tag_action_row_2, token_tag_action_row_0, token_tag_action_row_2, token_tag_action_row_0, token_tag_action_row_2, token_tag_action_row_0, token_tag_action_row_2, token_tag_action_row_0, token_tag_action_row_3, token_tag_action_row_2]
let token_tag_action_3 : Array[Array[Int]] = [token_tag_action_row_1, token_tag_action_row_2, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_0, token_tag_action_row_1, token_tag_action_row_2]

fn token_state_0(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     _ => (0, [])
   }
 }
fn token_state_1(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     0 => (9, token_tag_action_0)
     1..=8 => (11, token_tag_action_1)
     9 => (6, token_tag_action_2)
     10 => (3, token_tag_action_3)
     11..=12 => (11, token_tag_action_1)
     13 => (6, token_tag_action_2)
     14..=31 => (11, token_tag_action_1)
     32 => (6, token_tag_action_2)
     33..=100 => (11, token_tag_action_1)
     101 => (7, token_tag_action_4)
     102 => (10, token_tag_action_5)
     103..=104 => (11, token_tag_action_1)
     105 => (8, token_tag_action_6)
     106..=111 => (11, token_tag_action_1)
     112 => (4, token_tag_action_7)
     113..=114 => (11, token_tag_action_1)
     115 => (2, token_tag_action_8)
     116 => (12, token_tag_action_9)
     117..=121 => (11, token_tag_action_1)
     122 => (5, token_tag_action_10)
     123..=127 => (11, token_tag_action_1)
     _ => panic()
   }
 }
fn token_state_2(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     117 => (13, token_tag_action_11)
     _ => (0, [])
   }
 }
fn token_state_3(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     _ => (0, [])
   }
 }
fn token_state_4(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     114 => (14, token_tag_action_12)
     _ => (0, [])
   }
 }
fn token_state_5(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     101 => (15, token_tag_action_13)
     _ => (0, [])
   }
 }
fn token_state_6(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     0 => (9, token_tag_action_0)
     1..=8 => (11, token_tag_action_1)
     9 => (6, token_tag_action_2)
     10 => (3, token_tag_action_3)
     11..=12 => (11, token_tag_action_1)
     13 => (6, token_tag_action_2)
     14..=31 => (11, token_tag_action_1)
     32 => (6, token_tag_action_2)
     33..=100 => (11, token_tag_action_1)
     101 => (7, token_tag_action_4)
     102 => (10, token_tag_action_5)
     103..=104 => (11, token_tag_action_1)
     105 => (8, token_tag_action_6)
     106..=111 => (11, token_tag_action_1)
     112 => (4, token_tag_action_7)
     113..=114 => (11, token_tag_action_1)
     115 => (2, token_tag_action_8)
     116 => (12, token_tag_action_9)
     117..=121 => (11, token_tag_action_1)
     122 => (5, token_tag_action_10)
     123..=127 => (11, token_tag_action_1)
     _ => panic()
   }
 }
fn token_state_7(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     108 => (16, token_tag_action_14)
     _ => (0, [])
   }
 }
fn token_state_8(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     102 => (18, token_tag_action_15)
     115 => (17, token_tag_action_16)
     _ => (0, [])
   }
 }
fn token_state_9(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     _ => (0, [])
   }
 }
fn token_state_10(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     97 => (19, token_tag_action_17)
     _ => (0, [])
   }
 }
fn token_state_11(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     _ => (0, [])
   }
 }
fn token_state_12(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     104 => (21, token_tag_action_18)
     114 => (20, token_tag_action_19)
     _ => (0, [])
   }
 }
fn token_state_13(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     99 => (22, token_tag_action_11)
     _ => (0, [])
   }
 }
fn token_state_14(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     101 => (23, token_tag_action_12)
     _ => (0, [])
   }
 }
fn token_state_15(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     114 => (24, token_tag_action_13)
     _ => (0, [])
   }
 }
fn token_state_16(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     115 => (25, token_tag_action_14)
     _ => (0, [])
   }
 }
fn token_state_17(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     122 => (26, token_tag_action_16)
     _ => (0, [])
   }
 }
fn token_state_18(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     _ => (0, [])
   }
 }
fn token_state_19(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     108 => (27, token_tag_action_17)
     _ => (0, [])
   }
 }
fn token_state_20(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     117 => (28, token_tag_action_19)
     _ => (0, [])
   }
 }
fn token_state_21(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     101 => (29, token_tag_action_18)
     _ => (0, [])
   }
 }
fn token_state_22(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     99 => (30, token_tag_action_20)
     _ => (0, [])
   }
 }
fn token_state_23(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     100 => (31, token_tag_action_21)
     _ => (0, [])
   }
 }
fn token_state_24(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     111 => (32, token_tag_action_22)
     _ => (0, [])
   }
 }
fn token_state_25(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     101 => (33, token_tag_action_23)
     _ => (0, [])
   }
 }
fn token_state_26(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     101 => (34, token_tag_action_16)
     _ => (0, [])
   }
 }
fn token_state_27(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     115 => (35, token_tag_action_17)
     _ => (0, [])
   }
 }
fn token_state_28(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     101 => (36, token_tag_action_24)
     _ => (0, [])
   }
 }
fn token_state_29(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     110 => (37, token_tag_action_25)
     _ => (0, [])
   }
 }
fn token_state_30(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     _ => (0, [])
   }
 }
fn token_state_31(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     _ => (0, [])
   }
 }
fn token_state_32(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     _ => (0, [])
   }
 }
fn token_state_33(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     _ => (0, [])
   }
 }
fn token_state_34(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     114 => (38, token_tag_action_16)
     _ => (0, [])
   }
 }
fn token_state_35(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     101 => (39, token_tag_action_26)
     _ => (0, [])
   }
 }
fn token_state_36(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     _ => (0, [])
   }
 }
fn token_state_37(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     _ => (0, [])
   }
 }
fn token_state_38(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     111 => (40, token_tag_action_27)
     _ => (0, [])
   }
 }
fn token_state_39(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     _ => (0, [])
   }
 }
fn token_state_40(input : LexInput) -> (LexState, LexTagAction) {
   match input {
     _ => (0, [])
   }
 }

let __mbtlex_engine_token: LexEngine = { graph: [token_state_0, token_state_1, token_state_2, token_state_3, token_state_4, token_state_5, token_state_6, token_state_7, token_state_8, token_state_9, token_state_10, token_state_11, token_state_12, token_state_13, token_state_14, token_state_15, token_state_16, token_state_17, token_state_18, token_state_19, token_state_20, token_state_21, token_state_22, token_state_23, token_state_24, token_state_25, token_state_26, token_state_27, token_state_28, token_state_29, token_state_30, token_state_31, token_state_32, token_state_33, token_state_34, token_state_35, token_state_36, token_state_37, token_state_38, token_state_39, token_state_40, ], end_nodes: [None, None, Some((12, [((20, 0), (21, 0))])), Some((1, [((0, 0), (1, 0))])), Some((12, [((20, 0), (21, 0))])), Some((12, [((20, 0), (21, 0))])), Some((0, [])), Some((12, [((20, 0), (21, 0))])), Some((12, [((20, 0), (21, 0))])), Some((11, [])), Some((12, [((20, 0), (21, 0))])), Some((12, [((20, 0), (21, 0))])), Some((12, [((20, 0), (21, 0))])), None, None, None, None, None, Some((2, [((2, 0), (3, 0))])), None, None, None, None, None, None, None, None, None, None, None, Some((6, [((10, 0), (11, 0))])), Some((7, [((12, 0), (13, 0))])), Some((5, [((8, 0), (9, 0))])), Some((4, [((6, 0), (7, 0))])), None, None, Some((9, [((16, 0), (17, 0))])), Some((3, [((4, 0), (5, 0))])), None, Some((10, [((18, 0), (19, 0))])), Some((8, [((14, 0), (15, 0))]))], start_tags: [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20], code_blocks_n: 13 }
fn token( line_ctx :  LineTrackingContext, lexbuf : Lexbuf ) ->  (@parser.Token, @syntax.Pos, @syntax.Pos)!Error  {
 match __mbtlex_engine_token.run(lexbuf) {
 (0, __mbtlex_captures) => {
  token!(line_ctx, lexbuf) 
 }
 (1, __mbtlex_captures) => {
 let (_start_pos_of_t, _end_pos_of_t) = __mbtlex_captures[0]
 let t: String = lexbuf.substring(_start_pos_of_t, _end_pos_of_t)
 ignore(t)
  line_ctx.new_line(_end_pos_of_t); token!(line_ctx, lexbuf) 
 }
 (2, __mbtlex_captures) => {
 let (_start_pos_of_t, _end_pos_of_t) = __mbtlex_captures[0]
 let t: String = lexbuf.substring(_start_pos_of_t, _end_pos_of_t)
 ignore(t)
  (IF, line_ctx.pos(_start_pos_of_t), line_ctx.pos(_end_pos_of_t)) 
 }
 (3, __mbtlex_captures) => {
 let (_start_pos_of_t, _end_pos_of_t) = __mbtlex_captures[0]
 let t: String = lexbuf.substring(_start_pos_of_t, _end_pos_of_t)
 ignore(t)
  (THEN, line_ctx.pos(_start_pos_of_t), line_ctx.pos(_end_pos_of_t)) 
 }
 (4, __mbtlex_captures) => {
 let (_start_pos_of_t, _end_pos_of_t) = __mbtlex_captures[0]
 let t: String = lexbuf.substring(_start_pos_of_t, _end_pos_of_t)
 ignore(t)
  (ELSE, line_ctx.pos(_start_pos_of_t), line_ctx.pos(_end_pos_of_t)) 
 }
 (5, __mbtlex_captures) => {
 let (_start_pos_of_t, _end_pos_of_t) = __mbtlex_captures[0]
 let t: String = lexbuf.substring(_start_pos_of_t, _end_pos_of_t)
 ignore(t)
  (ZERO, line_ctx.pos(_start_pos_of_t), line_ctx.pos(_end_pos_of_t)) 
 }
 (6, __mbtlex_captures) => {
 let (_start_pos_of_t, _end_pos_of_t) = __mbtlex_captures[0]
 let t: String = lexbuf.substring(_start_pos_of_t, _end_pos_of_t)
 ignore(t)
  (SUCC, line_ctx.pos(_start_pos_of_t), line_ctx.pos(_end_pos_of_t)) 
 }
 (7, __mbtlex_captures) => {
 let (_start_pos_of_t, _end_pos_of_t) = __mbtlex_captures[0]
 let t: String = lexbuf.substring(_start_pos_of_t, _end_pos_of_t)
 ignore(t)
  (PRED, line_ctx.pos(_start_pos_of_t), line_ctx.pos(_end_pos_of_t)) 
 }
 (8, __mbtlex_captures) => {
 let (_start_pos_of_t, _end_pos_of_t) = __mbtlex_captures[0]
 let t: String = lexbuf.substring(_start_pos_of_t, _end_pos_of_t)
 ignore(t)
  (ISZERO, line_ctx.pos(_start_pos_of_t), line_ctx.pos(_end_pos_of_t)) 
 }
 (9, __mbtlex_captures) => {
 let (_start_pos_of_t, _end_pos_of_t) = __mbtlex_captures[0]
 let t: String = lexbuf.substring(_start_pos_of_t, _end_pos_of_t)
 ignore(t)
  (TRUE, line_ctx.pos(_start_pos_of_t), line_ctx.pos(_end_pos_of_t)) 
 }
 (10, __mbtlex_captures) => {
 let (_start_pos_of_t, _end_pos_of_t) = __mbtlex_captures[0]
 let t: String = lexbuf.substring(_start_pos_of_t, _end_pos_of_t)
 ignore(t)
  (FALSE, line_ctx.pos(_start_pos_of_t), line_ctx.pos(_end_pos_of_t)) 
 }
 (11, __mbtlex_captures) => {
  raise EndOfFile 
 }
 (12, __mbtlex_captures) => {
 let (_start_pos_of_t, _end_pos_of_t) = __mbtlex_captures[0]
 let t: String = lexbuf.substring(_start_pos_of_t, _end_pos_of_t)
 ignore(t)
  raise UnrecognizedChar(line_ctx.pos(_start_pos_of_t), t[0]) 
 }
 _ => abort("lex: fail to match")
 }
 }


pub fn tokenize(input : String) -> Array[(@parser.Token, @syntax.Pos, @syntax.Pos)]!LexError {
   let buf = Lexbuf::from_string(input)
   let line_ctx = { line: 1, line_start: 0 }
   let result = []
   while true {
     try token!(line_ctx, buf) catch {
       EndOfFile => break
       UnrecognizedChar(_) as err => raise err
       _ => panic()
     } else {
       triple => result.push(triple)
     }
   }
   result
 }
