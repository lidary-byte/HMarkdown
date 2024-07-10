import { marked } from './core'
import { Tokens, TokensList } from './core/Tokens'
import { blockRule } from './plugin/LatexPlugin'


export function init() {

}

@Concurrent
export default function parseTask(src: string): TokensList {
  marked.use({
    extensions: [
      {
        name: 'blockKatex',
        level: 'block',
        tokenizer(src: string): Tokens.Generic | undefined {
          const match = src.match(blockRule);
          if (match) {
            return {
              type: 'blockKatex',
              raw: match[0],
              text: match[2].trim(),
              displayMode: match[1].length === 2,
            }
          }
          return undefined
        },
        childTokens: ['latex']
      }
    ]
  })
  // const tokenizer = new mark.Tokenizer()
  // let lexer = new mark.Lexer({
  //   tokenizer: tokenizer,
  //   gfm: true,
  // })
  return marked.lexer(src)
  // return lexer.lex(src)
}