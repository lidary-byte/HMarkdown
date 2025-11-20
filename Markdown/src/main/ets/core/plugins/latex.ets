import { TokenizerExtension, Tokens } from '../marked';



export function latexBlock(): TokenizerExtension {
  return {
    name: 'blockLatex',
    level: 'block',
    start: (src: string): number | void => {
      let index = 0;
      let indexSrc = src
      while (indexSrc) {
        index = indexSrc.indexOf('$$');
        if (index == -1) {
          return
        }
        if (index > -1 || indexSrc.charAt(index - 1) === ' ') {
          const possibleKatex = indexSrc.substring(index);

          if (possibleKatex.startsWith('$$')) {
            return index;
          }
        }
        indexSrc = indexSrc.substring(index + 2).replace(/^\$+/, '');
      }
    },
    tokenizer(src: string): Tokens.Generic | undefined {
      if (src.startsWith("$$")) {
        const end = src.indexOf('$$', 2)
        return {
          type: 'blockLatex',
          raw: src.substring(0, end + 2),
          text: src.substring(2, end - 1).trim()
        }
      }
      return undefined
    },
  }
}

export function latexInline(): TokenizerExtension {
  return {
    name: 'inlineLatex',
    level: 'inline',
    start: (src: string): number | void => {
      let index = 0;
      let indexSrc = src
      while (indexSrc) {
        index = indexSrc.indexOf('$');
        if (index === -1) {
          return
        }
        if (index > -1 || indexSrc.charAt(index - 1) === ' ') {
          const possibleKatex = indexSrc.substring(index);

          if (possibleKatex.startsWith('$')) {
            return index;
          }
        }

        indexSrc = indexSrc.substring(index + 1).replace(/^\$+/, '');
      }
    },
    tokenizer: (src: string): Tokens.Generic | undefined => {
      if (src.startsWith("$")) {
        const end = src.indexOf('$', 2)
        return {
          type: 'inlineLatex',
          raw: src.substring(0, end+1),
          text: src.substring(1, end).trim()
        }
      }
      return undefined
    },
  }
}

