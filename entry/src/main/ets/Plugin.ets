/**
 * @Author : lcc
 * @CreateData : 2024/7/11
 * @Description:
 */
import { TokenizerExtension, Tokens } from '@lidary/markdown';

const inlineRule = /^(\${1,2})(?!\$)((?:\\.|[^\\\n])*?(?:\\.|[^\\\n\$]))\1(?=[\s?!\.,:？！。，：]|$)/;

export const blockRule = /^(\${1,2})\n((?:\\[^]|[^\\])+?)\n\1(?:\n|$)/;

export function latexBlock(): TokenizerExtension {
  return {
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
  }
}

export function latexInline(): TokenizerExtension {
  return {
    name: 'inlineKatex',
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
          type: 'inlineKatex',
          raw: match[0],
          text: match[2].trim(),
          displayMode: match[1].length === 2
        }
      }
      return undefined
    },
  }
}

