/**
 * @Author : lcc
 * @CreateData : 2024/7/7
 * @Description:
 */
import { LatexMathColorFormat, latexStringToImage } from '@cangjie-tpc/formula_hybrid';
import { promptAction } from '@kit.ArkUI';
import { BusinessError, pasteboard } from '@kit.BasicServicesKit';
import { marked, Token } from './core';
import { image } from '@kit.ImageKit';


/**
 * 清理实体字符
 * @param content
 * @returns
 */
export function clearMarkdown(content: string) {
  return content.replaceAll('&amp;', '&')
    .replaceAll('&lt;', '<')
    .replaceAll('&gt;', '>')
    .replaceAll('&quot;', '"')
    .replaceAll('&#39;', '""')
}

/**
 * 判断字符串的第一个字符是否为数字
 * @param str 要检查的字符串
 * @returns 如果第一个字符是数字，则返回 true；否则返回 false
 */
export function isFirstCharDigit(str: string): boolean {
  if (str.length === 0) {
    return false;
  }
  return /^\d/.test(str.charAt(0));
}

@Concurrent
export function parseMarkdown(content: string,): Token[] {
  if (content) {
    return marked.lexer(content)
  }
  return []
}

export function textAlign(align?: 'center' | 'left' | 'right' | null) {
  if (align === 'left') {
    return TextAlign.Start
  }
  if (align === 'right') {
    return TextAlign.End
  }
  return TextAlign.Center
}


export async function copyToPasteboard(text?: string) {
  if (!text) {
    return
  }
  let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, text);
  let systemPasteboard = pasteboard.getSystemPasteboard();
  await systemPasteboard.setData(pasteData).then((data) => {
    promptAction.showToast({
      message: '复制成功'
    });
  }).catch((err: BusinessError) => {
    promptAction.showToast({
      message: '复制异常' + err.message
    });
  });
}

export async function latexToPixelMap(latexText: string, latexMathTextSize: number, latexMathTextColor: number,
  latexMathBackGroupColor: number): Promise<LatexToPixelMap> {

  // 通过接口解析数学公式获取数学公式图片数组数据
  let buf: ArrayBuffer =
    await latexStringToImage(latexText, latexMathTextSize, latexMathTextColor, latexMathBackGroupColor,
      LatexMathColorFormat.COLOR_FORMAT_BGRA_8888)
  let imageSource = image.createImageSource(buf)
  // 图片pixelMap
  let pixelMap = imageSource.createPixelMapSync()
  let size: Size = pixelMap.getImageInfoSync().size
  return {
    pixelMap: pixelMap,
    width: size.width,
    height: size.height
  }
}

export interface LatexToPixelMap {
  pixelMap: image.PixelMap,
  width: number
  height: number
}

