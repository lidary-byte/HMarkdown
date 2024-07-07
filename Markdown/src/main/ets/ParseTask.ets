import { marked } from './core'
import { TokensList } from './core/Tokens'

@Concurrent
export default function parseTask(src: string): TokensList {
  // marked.use(LatexPlugin())
  const tokenizer = new marked.Tokenizer()
  let lexer = new marked.Lexer({
    tokenizer: tokenizer,
    gfm: true
  })
  return lexer.lex(src)
}