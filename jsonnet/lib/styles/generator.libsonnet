// 样式生成库
local constants = import '../core/constants.libsonnet';
local utils = import '../core/utils.libsonnet';
local theme = import '../core/theme.libsonnet';

// 生成基础样式
local generateBaseStyles = function(theme) {
  local themeData = theme.getTheme(theme);
  
  {
    // 字母键样式
    alphabeticBackgroundStyle: utils.makeButtonStyle(theme, 'alphabetic', 'normal'),
    alphabeticBackgroundHighlightStyle: utils.makeButtonStyle(theme, 'alphabetic', 'highlight'),
    
    // 功能键样式
    systemButtonBackgroundStyle: utils.makeButtonStyle(theme, 'function', 'normal'),
    systemButtonBackgroundHighlightStyle: utils.makeButtonStyle(theme, 'function', 'highlight'),
    
    // 回车键样式
    enterButtonGreenBackgroundStyle: utils.makeGeometryStyle(
      themeData.enterKey.backgroundGreen,
      constants.BUTTON.CORNER_RADIUS,
      constants.BUTTON.INSETS,
      themeData.enterKey.backgroundLowerEdgeNormal
    ),
    
    // 动画样式
    ButtonScaleAnimation: constants.ANIMATION.BUTTON_SCALE,
    
    // 键盘背景样式
    keyboardBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: themeData.keyboardBackground,
    },
    
    // 气泡样式
    alphabeticHintBackgroundStyle: utils.makeGeometryStyle(
      themeData.candidate.selected,
      constants.BUTTON.HINT_CORNER_RADIUS,
      {},
      {}
    ),
    alphabeticHintBackgroundStyle: utils.makeGeometryStyle(
      themeData.candidate.selected,
      constants.BUTTON.HINT_CORNER_RADIUS,
      {},
      {}
    ),
    
    // 符号集合样式
    alphabeticHintSymbolsBackgroundStyle: utils.makeImageStyle(
      'hold_back',
      'IMG1',
      'center',
      constants.BUTTON.INSETS
    ),
    alphabeticHintSymbolsSelectedStyle: utils.makeImageStyle(
      'hint',
      'IMG1',
      'center',
      { bottom: 8, left: 4, right: 3, top: 8 }
    ),
  };
};

// 生成回车键样式
local generateEnterButtonStyles = function(theme) {
  local themeData = theme.getTheme(theme);
  
  {
    enterButtonForegroundStyle0: utils.makeSymbolStyle(
      'return.left',
      constants.FONT_SIZE.BUTTON.TEXT,
      themeData.enterKey.textNormal,
      constants.OFFSET.FUNCTION_KEY
    ),
    enterButtonForegroundStyle14: utils.makeSymbolStyle(
      'arrowshape.turn.up.forward',
      constants.FONT_SIZE.BUTTON.TEXT,
      themeData.enterKey.textHighlight,
      constants.OFFSET.FUNCTION_KEY
    ),
    enterButtonForegroundStyle6: utils.makeSymbolStyle(
      'magnifyingglass',
      constants.FONT_SIZE.BUTTON.TEXT,
      themeData.enterKey.textHighlight,
      constants.OFFSET.FUNCTION_KEY
    ),
    enterButtonForegroundStyle7: utils.makeSymbolStyle(
      'paperplane',
      constants.FONT_SIZE.BUTTON.TEXT,
      themeData.enterKey.textHighlight,
      constants.OFFSET.FUNCTION_KEY
    ),
    enterButtonForegroundStyle9: utils.makeSymbolStyle(
      'checkmark.app.stack',
      constants.FONT_SIZE.BUTTON.TEXT,
      themeData.enterKey.textHighlight,
      constants.OFFSET.FUNCTION_KEY
    ),
    
    // 通知样式
    garyReturnKeyTypeNotification: {
      notificationType: 'returnKeyType',
      returnKeyType: [0, 2, 3, 5, 8, 10, 11],
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'enterButtonForegroundStyle0',
    },
    blueReturnKeyTypeNotification14: {
      notificationType: 'returnKeyType',
      returnKeyType: [1, 4],
      backgroundStyle: 'enterButtonGreenBackgroundStyle',
      foregroundStyle: 'enterButtonForegroundStyle14',
    },
    blueReturnKeyTypeNotification6: {
      notificationType: 'returnKeyType',
      returnKeyType: [6],
      backgroundStyle: 'enterButtonGreenBackgroundStyle',
      foregroundStyle: 'enterButtonForegroundStyle6',
    },
    blueReturnKeyTypeNotification7: {
      notificationType: 'returnKeyType',
      returnKeyType: [7],
      backgroundStyle: 'enterButtonGreenBackgroundStyle',
      foregroundStyle: 'enterButtonForegroundStyle7',
    },
    blueReturnKeyTypeNotification9: {
      notificationType: 'returnKeyType',
      returnKeyType: [9],
      backgroundStyle: 'enterButtonGreenBackgroundStyle',
      foregroundStyle: 'enterButtonForegroundStyle9',
    },
  };
};

// 生成功能键样式
local generateFunctionKeyStyles = function(theme) {
  local themeData = theme.getTheme(theme);
  
  {
    // 切换中英文键
    EnZhButtonForegroundStyle: utils.makeImageStyle(
      'cnen',
      'IMG1',
      'center',
      constants.BUTTON.INSETS
    ),
    
    // 符号键
    symbolButtonForegroundStyle: utils.makeTextStyle(
      '符',
      constants.FONT_SIZE.BUTTON.TEXT,
      themeData.functionKey.textNormal,
      { x: 0.5, y: 0.48 }
    ),
    
    // 数字键
    numberButtonForegroundStyle: utils.makeTextStyle(
      '123',
      constants.FONT_SIZE.BUTTON.TEXT,
      themeData.functionKey.textNormal,
      constants.OFFSET.FUNCTION_KEY
    ),
    
    // 删除键
    backspaceButtonForegroundStyle: utils.makeSymbolStyle(
      'delete.left',
      constants.FONT_SIZE.BUTTON.TEXT,
      themeData.functionKey.textNormal,
      constants.OFFSET.FUNCTION_KEY
    ),
    
    // Shift键
    shiftButtonForegroundStyle: utils.makeSymbolStyle(
      'arrow.up',
      constants.FONT_SIZE.BUTTON.TEXT,
      themeData.functionKey.textNormal,
      constants.OFFSET.FUNCTION_KEY
    ),
  };
};

// 导出样式生成函数
{
  generateBaseStyles: generateBaseStyles,
  generateEnterButtonStyles: generateEnterButtonStyles,
  generateFunctionKeyStyles: generateFunctionKeyStyles,
}