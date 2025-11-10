/**
 * @Author : lcc
 * @CreateData : 2024/7/7
 * @Description:
 */
import { promptAction } from '@kit.ArkUI';
import { BusinessError, pasteboard } from '@kit.BasicServicesKit';
import { marked, Token } from './core';


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
export function parseMarkdown(content: string): Token[] {
  if (content) {
    return marked.lexer(content)
  }
  return []
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