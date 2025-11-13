import { TokenizerExtension, Tokens } from "../marked";


const inlineRule = /^(\${1,2})(?!\$)((?:\\.|[^\\\n])*?(?:\\.|[^\\\n\$]))\1(?=[\s?!\.,:？！。，：]|$)/;

const blockRule = /^(\${1,2})\n((?:\\[^]|[^\\])+?)\n\1(?:\n|$)/;



export function latexBlock(): TokenizerExtension {
  return {
    name: 'blockLatex',
    level: 'block',
    tokenizer(src: string): Tokens.Generic | undefined {
      const match = src.match(blockRule);
      if (match) {
        return {
          type: 'blockLatex',
          raw: match[0],
          text: match[2].trim(),
          displayMode: match[1].length === 2,
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
        if (index === 0 || indexSrc.charAt(index - 1) === ' ') {
          const possibleKatex = indexSrc.substring(index);

          if (possibleKatex.match(inlineRule)) {
            return index;
          }
        }

        indexSrc = indexSrc.substring(index + 1).replace(/^\$+/, '');
      }
    },
    tokenizer: (src: string): Tokens.Generic | undefined => {
      const match = src.match(inlineRule);
      if (match) {
        return {
          type: 'inlineLatex',
          raw: match[0],
          text: match[2].trim(),
          displayMode: match[1].length === 2
        }
      }
      return undefined
    },
  }
}

