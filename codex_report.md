# Dependency build failure

`moon check` does not reach this repository's source packages. It fails while
building binary dependency `moonbitlang/lex`.

Current dependency declarations in `moon.mod.json`:

```json
{
  "bin-deps": {
    "moonbitlang/lex": "0.3.8",
    "moonbitlang/yacc": "0.6.11"
  }
}
```

Attempted updates:

- `moon add moonbitlang/lex`
- `moon add moonbitlang/yacc`

The dependency build still fails after those attempts, and `moon.mod.json`
remains unchanged because the update commands exit with errors during
dependency build resolution.

Representative errors from `moonbitlang/lex`:

```text
Error: Building binary dependency `moonbitlang/lex` failed
```

Nested dependency `Yoorkin/trie` fails with syntax that the current compiler no
longer accepts:

```text
.mooncakes/moonbitlang/lex/.mooncakes/Yoorkin/trie/trie.mbt:7:26
Parse error, unexpected token `,`, you may expect `{`.

.mooncakes/moonbitlang/lex/.mooncakes/Yoorkin/trie/trie.mbt:36:14
Expected upper case identifier for type parameter, found lower case identifier.
```

Nested dependency `moonbitlang/x` also fails under
`internal/ffi/string_convert.mbt` with `UInt16` versus `Int` type mismatches and
an out-of-range integer literal:

```text
Expr Type Mismatch
has type : UInt16
wanted   : Int

Integer literal 0x10000 is out of range.
```

Additional `moonbitlang/lex` package errors include iterator API and trait
implementation breakages:

```text
Type InorderIterator[N] has no method inner.
This function has type () -> (N, N)?, which expects 0 argument(s), but is given 1 argument(s).
There is no method op_equal in trait Eq.
```

This appears to be dependency incompatibility with the installed MoonBit
toolchain rather than an error in the current repository's source files.
