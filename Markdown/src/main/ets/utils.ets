/**
 * @Author : lcc
 * @CreateData : 2024/7/7
 * @Description:
 */
import { promptAction } from '@kit.ArkUI';
import { BusinessError, pasteboard } from '@kit.BasicServicesKit';

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