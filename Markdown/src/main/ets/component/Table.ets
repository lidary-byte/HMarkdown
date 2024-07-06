/**
 * @Author : lcc
 * @CreateData : 2024/7/4
 * @Description:
 */
import { Tokens } from '../core'

@Component
export struct TableHeader{
  tokens: Tokens.TableCell[] = []
  textAlign: TextAlign[] = []

  build() {
    Row() {
      ForEach(this.tokens, (item: Tokens.TableCell, index: number) => {
        Text(item.text)
          .width((100 / this.tokens.length) + '%')
          .padding({
            left: 10,
            right: 10,
            top: 15,
            bottom: 15
          })
          .fontWeight(FontWeight.Bold)
          .textAlign(this.textAlign[index])
          // .fontColor(this.style?.base?.fontColor)
      })
    }
    .width('100%')
    // .backgroundColor(this.style?.table?.headerBackgroundColor)
  }
}

@Component
struct TableBody {
  tokens: Tokens.TableCell[][] = []
  textAlign: TextAlign[] = []

  build() {
    Row() {
      Column() {
        ForEach(this.tokens, (row: Tokens.TableCell[], index: number) => {
          Row() {
            ForEach(row, (item: Tokens.TableCell, eIndex: number) => {
              Row() {
                Text(item.text)
                  .padding({
                    bottom: 10,
                    top: 10,
                    left: 10,
                    right: 10,
                  })
                  .textAlign(this.textAlign[eIndex])
                  // .fontColor(this.style?.base?.fontColor)
              }.width((100 / row.length) + '%')
            })
          }
          .width('100%')
          // .backgroundColor(index % 2 === 0 ? this.style?.table?.evenRowBackgroundColor : this.style?.table?.oddRowBackgroundColor)
        })
      }
    }
    .width('100%')
  }
}

@Component
export struct Table {
  token?: Tokens.Table
  // style?: BiuMarkDownStyle
  private textAlign: TextAlign[] = []

  aboutToAppear() {
    this.token?.align.forEach(a => {
      if (a === 'center') {
        this.textAlign.push(TextAlign.Center);
      } else if (a === 'right') {
        this.textAlign.push(TextAlign.End)
      } else {
        this.textAlign.push(TextAlign.Start)
      }
    })
  }

  build() {
    Column() {
      TableHeader({
        tokens: this.token?.header,
        // style: this.style,
        textAlign: this.textAlign
      })
      TableBody({
        tokens: this.token?.rows,
        // style: this.style,
        textAlign: this.textAlign
      })
    }
    .border({
      width: 1,
      // color: this.style?.table?.borderColor,
      style: BorderStyle.Solid
    })
  }
}