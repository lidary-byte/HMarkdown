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

export function parseMarkdown(content: string): Token[] {
  if (content) {
    return marked.lexer(content, {
      async: true,
      gfm: true,
    })
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