import { Token } from '../../flexible_rich_text/lib/Tokens'
import { BiuMarkDownStyle, ComponentStyle, mergeParent } from '../../flexible_rich_text/style/BiuMarkdownStyle'

export type AnalysisLine = Element[]

export type AdditionalAttributes = Map<string, ESObject>

export class Element {
  type: string
  style: ComponentStyle
  additionalAttributes?: AdditionalAttributes
  text: string

  constructor(type: string, text: string, style: ComponentStyle, additionalAttributes?: AdditionalAttributes) {
    this.type = type
    this.text = text
    this.style = style
    this.additionalAttributes = additionalAttributes
  }
}

export class InlineAnalyzer {
  token: Token
  style?: BiuMarkDownStyle
  componentStyle?: ComponentStyle
  stack: string[]
  additionalAttributesStack: AdditionalAttributes[]
  lines: AnalysisLine[]
  currentLine: AnalysisLine

  constructor(token: Token, style?: BiuMarkDownStyle, componentStyle?: ComponentStyle) {
    this.token = token
    this.style = style
    this.stack = []
    this.lines = []
    this.currentLine = [] as Element[]
    this.componentStyle = componentStyle
    this.additionalAttributesStack = [] as AdditionalAttributes[]
  }

  doAnalysis(): AnalysisLine[] {
    this.analysis(this.token)
    this.lines.push(this.currentLine)
    return this.lines
  }

  private isLeaf(token: Token) {
    let tokens: ESObject = token['tokens']
    if (tokens) {
      return false
    } else {
      return true
    }
  }

  private buildComponentStyle(): ComponentStyle {
    let res: ComponentStyle = new ComponentStyle(this.style)
    if (this.componentStyle) {
      this.componentStyle.forEach((value: ESObject, key) => {
        res.set(key, value)
      })
    }
    for (let index = 0; index < this.stack.length; index++) {
      res = mergeParent(this.stack[index], this.style, res)
    }
    return res
  }

  private buildAdditionalAttributes(newAdditionalAttributes: AdditionalAttributes): AdditionalAttributes {
    let res: AdditionalAttributes = new Map()
    let last = this.getAdditionalAttributes()
    if (last) {
      last.forEach((value: ESObject, key) => {
        res.set(key, value)
      })
    }
    if (newAdditionalAttributes) {
      newAdditionalAttributes.forEach((value: ESObject, key) => {
        res.set(key, value)
      })
    }
    return res
  }

  private getAdditionalAttributes(): AdditionalAttributes | undefined {
    if (this.additionalAttributesStack.length > 0) {
      return this.additionalAttributesStack[this.additionalAttributesStack.length-1]
    }
    return undefined
  }

  private analysis(token: Token) {
    this.stack.push(token.type)
    if (this.isLeaf(token)) {
      if (token.type === 'image') {
        let aa = this.buildAdditionalAttributes(new Map([
          ['image', {
            href: token.href
          } as ESObject]
        ]))
        this.lines.push(this.currentLine)
        this.lines.push([
          new Element(token.type, token.text, this.buildComponentStyle(), aa)
        ])
        this.currentLine = []
      } else if (token.type === 'latex') {
        let aa = this.buildAdditionalAttributes(new Map([
          ['latex', {
            content: token.text
          } as ESObject]
        ]))
        this.lines.push(this.currentLine)
        this.lines.push([
          new Element(token.type, token.text, this.buildComponentStyle(), aa)
        ])
        this.currentLine = []
      } else {
        this.currentLine.push(
          new Element(
            token.type,
            token['text'] as string,
            this.buildComponentStyle(),
            this.getAdditionalAttributes()
          ))
      }
    } else {
      let pushAdditionalAttributesFlag: boolean = false
      if (token.type === 'link') {
        let aa = this.buildAdditionalAttributes(new Map([
          ['link', { href: token.href } as ESObject]
        ]))
        this.additionalAttributesStack.push(aa)
        pushAdditionalAttributesFlag = true
      }
      let tokens: ESObject = token['tokens']
      for (let index = 0; index < tokens.length; index++) {
        this.analysis(tokens[index])
      }
      if (pushAdditionalAttributesFlag) {
        this.additionalAttributesStack.pop()
      }
    }
    this.stack.pop()
  }
}