/**
 * @Author : lcc
 * @CreateData : 2024/7/3
 * @Description:
 */
import { MarkedExtension, MarkedOptions, TokenizerExtension, Tokens } from '../core';

// import katex from 'katex';

const inlineRule = /^(\${1,2})(?!\$)((?:\\.|[^\\\n])*?(?:\\.|[^\\\n\$]))\1(?=[\s?!\.,:？！。，：]|$)/;

export const blockRule = /^(\${1,2})\n((?:\\[^]|[^\\])+?)\n\1(?:\n|$)/;



export default function LatexPlugin(options: MarkedOptions = {}): MarkedExtension {
  return {
    extensions: [
    // inlineKatex(options, createRenderer(options, false)),
    //   blockKatex(options, []),
    //   descriptionList,
      {
        name: 'blockKatex',
        level: 'block',
        tokenizer(src: string): Tokens.Generic {
          const match = src.match(blockRule);
          if (match) {
            return {
              type: 'blockKatex',
              raw: match[0],
              text: match[2].trim(),
              displayMode: match[1].length === 2,
            }
          }
        },
        renderer(token: Tokens.Generic): string {
          return `<latex>${token.tokens}</latex>`
        },
        childTokens: ['latex']
      }
    ]
  };
}


function createRenderer(options: MarkedOptions, newlineAfter: boolean): string[] | undefined {
  // return (token) => katex.renderToString(token.text, { ...options, displayMode: token.displayMode }) +
  //   (newlineAfter ? '\n' : '');

  return []
}


function blockKatex(options: MarkedOptions, renderer: string[] | undefined): TokenizerExtension {
  return {
    name: 'blockKatex',
    level: 'block',
    tokenizer(src: string): ESObject {
      const match = src.match(blockRule);
      if (match) {
        return {
          type: 'blockKatex',
          raw: match[0],
          text: match[2].trim(),
          displayMode: match[1].length === 2,
        }
      }
    },
    // childTokens: renderer
  };
}

// function inlineKatex(options:MarkedOptions, renderer : Renderer):TokenizerAndRendererExtension {
//   return {
//     name: 'inlineKatex',
//     level: 'inline',
//     start(src) {
//       let index;
//       let indexSrc = src;
//
//       while (indexSrc) {
//         index = indexSrc.indexOf('$');
//         if (index === -1) {
//           return;
//         }
//
//         if (index === 0 || indexSrc.charAt(index - 1) === ' ') {
//           const possibleKatex = indexSrc.substring(index);
//
//           if (possibleKatex.match(inlineRule)) {
//             return index;
//           }
//         }
//
//         indexSrc = indexSrc.substring(index + 1).replace(/^\$+/, '');
//       }
//     },
//     tokenizer(src, tokens) {
//       const match = src.match(inlineRule);
//       if (match) {
//         return {
//           type: 'inlineKatex',
//           raw: match[0],
//           text: match[2].trim(),
//           displayMode: match[1].length === 2
//         };
//       }
//     },
//     renderer
//   };
// }
