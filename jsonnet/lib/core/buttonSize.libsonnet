// 按键尺寸定义
local constants = import '../core/constants.libsonnet';

{
  // 竖屏按键尺寸
  portrait: {
    normalKey: { width: { percentage: constants.PORTRAIT_BUTTON_WIDTH.NORMAL } },
    shiftKey: { width: { percentage: constants.PORTRAIT_BUTTON_WIDTH.SHIFT } },
    backspaceKey: { width: { percentage: constants.PORTRAIT_BUTTON_WIDTH.BACKSPACE } },
    enZhKey: { width: { percentage: constants.PORTRAIT_BUTTON_WIDTH.EN_ZH } },
    symbolKey: { width: { percentage: constants.PORTRAIT_BUTTON_WIDTH.SYMBOL } },
    numberKey: { width: { percentage: constants.PORTRAIT_BUTTON_WIDTH.NUMBER } },
    spaceKey: { width: { percentage: constants.PORTRAIT_BUTTON_WIDTH.SPACE } },
    spaceRightKey: { width: { percentage: constants.PORTRAIT_BUTTON_WIDTH.SPACE_RIGHT } },
    enterKey: { width: { percentage: constants.PORTRAIT_BUTTON_WIDTH.ENTER } },
  },
  
  // 横屏按键尺寸
  landscape: {
    normalKey: { width: constants.LANDSCAPE_BUTTON_WIDTH.NORMAL },
    tKey: { width: constants.LANDSCAPE_BUTTON_WIDTH.WIDE },
    yKey: { width: constants.LANDSCAPE_BUTTON_WIDTH.WIDE },
    aKey: { width: constants.LANDSCAPE_BUTTON_WIDTH.WIDE },
    pKey: { width: constants.LANDSCAPE_BUTTON_WIDTH.WIDE },
    lKey: { width: constants.LANDSCAPE_BUTTON_WIDTH.WIDE },
    shiftKey: { width: constants.LANDSCAPE_BUTTON_WIDTH.SHIFT },
    backspaceKey: { width: constants.LANDSCAPE_BUTTON_WIDTH.BACKSPACE },
    enZhKey: { width: constants.LANDSCAPE_BUTTON_WIDTH.EN_ZH },
    symbolKey: { width: constants.LANDSCAPE_BUTTON_WIDTH.SYMBOL },
    numberKey: { width: constants.LANDSCAPE_BUTTON_WIDTH.NUMBER },
    spaceKey: { width: constants.LANDSCAPE_BUTTON_WIDTH.SPACE },
    spaceRightKey: { width: constants.LANDSCAPE_BUTTON_WIDTH.SPACE_RIGHT },
    enterKey: { width: constants.LANDSCAPE_BUTTON_WIDTH.ENTER },
    vKey: { width: constants.LANDSCAPE_BUTTON_WIDTH.V_B_N },
    bKey: { width: constants.LANDSCAPE_BUTTON_WIDTH.V_B_N },
    nKey: { width: constants.LANDSCAPE_BUTTON_WIDTH.V_B_N },
  },
  
  // 获取按键尺寸
  getButtonSize(orientation): if orientation == 'landscape' then self.landscape else self.portrait,
}