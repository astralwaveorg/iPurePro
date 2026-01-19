// 主题颜色定义
local constants = import '../core/constants.libsonnet';

{
  light: {
    // 背景颜色
    background: '#FFFFFF',
    keyboardBackground: '#FFFFFF',

    // 字母键颜色
    alphabeticKey: {
      backgroundNormal: '#FFFFFF',
      backgroundHighlight: '#ABB0BA',
      backgroundLowerEdgeNormal: '#9a9c9a',
      backgroundLowerEdgeHighlight: '#979faf80',
      textNormal: '#000000',
      textHighlight: '#000000',
    },

    // 功能键颜色
    functionKey: {
      backgroundNormal: '#ABB0BA',
      backgroundHighlight: '#979faf80',
      textNormal: '#000000',
      textHighlight: '#000000',
    },

    // 回车键颜色（绿色）
    enterKey: {
      backgroundGreen: '#23C891',
      backgroundNormal: '#FFFFFF',
      textNormal: '#000000',
      textHighlight: '#FFFFFF',
      backgroundLowerEdgeNormal: '#9a9c9a',
      backgroundLowerEdgeHighlight: '#979faf80',
    },

    // 文本颜色
    text: {
      primary: '#000000',
      secondary: '#00000066',
      accent: '#1fb382',
      swipe: '#00000066',
    },

    // 候选栏颜色
    candidate: {
      text: '#000000',
      index: '#000000',
      comment: '#000000',
      preferred: '#1fb382',
      background: '#FFFFFF',
      selected: '#0279FE',
    },

    // 气泡颜色
    bubble: {
      background: '#FFFFFF',
      backgroundSelected: '#0279FE',
      text: '#000000',
      textSelected: '#FFFFFF',
    },

    // 工具栏颜色
    toolbar: {
      text: '#7F7F7F',
      background: '#FFFFFF',
    },

    // 长按选中颜色
    longPress: {
      selected: '#1fb382',
      unselected: '#2E2E2E',
    },
  },

  dark: {
    // 背景颜色
    background: '#000000',
    keyboardBackground: '#000000',

    // 字母键颜色
    alphabeticKey: {
      backgroundNormal: '#FFFFFF',
      backgroundHighlight: '#ABB0BA',
      backgroundLowerEdgeNormal: '#9a9c9a',
      backgroundLowerEdgeHighlight: '#979faf80',
      textNormal: '#000000',
      textHighlight: '#000000',
    },

    // 功能键颜色
    functionKey: {
      backgroundNormal: '#ABB0BA',
      backgroundHighlight: '#979faf80',
      textNormal: '#000000',
      textHighlight: '#000000',
    },

    // 回车键颜色（绿色）
    enterKey: {
      backgroundGreen: '#23C891',
      backgroundNormal: '#FFFFFF',
      textNormal: '#000000',
      textHighlight: '#FFFFFF',
      backgroundLowerEdgeNormal: '#9a9c9a',
      backgroundLowerEdgeHighlight: '#979faf80',
    },

    // 文本颜色
    text: {
      primary: '#FFFFFF',
      secondary: '#FFFFFF66',
      accent: '#27dfa1',
      swipe: '#FFFFFF66',
    },

    // 候选栏颜色
    candidate: {
      text: '#FFFFFF',
      index: '#FFFFFF',
      comment: '#FFFFFF',
      preferred: '#27dfa1',
      background: '#000000',
      selected: '#0279FE',
    },

    // 气泡颜色
    bubble: {
      background: '#000000',
      backgroundSelected: '#0279FE',
      text: '#FFFFFF',
      textSelected: '#FFFFFF',
    },

    // 工具栏颜色
    toolbar: {
      text: '#7F7F7F',
      background: '#000000',
    },

    // 长按选中颜色
    longPress: {
      selected: '#27dfa1',
      unselected: '#E5E5E5',
    },
  },

  // 获取主题颜色
  getTheme(themeName)::
    if themeName == 'dark' then
      self.dark
    else
      self.light,

  // 获取按键背景颜色
  getButtonBackground: function(themeName, keyType, state) {
    local theme = self.getTheme(themeName);
    if keyType == 'alphabetic' then theme.alphabeticKey
    else if keyType == 'function' then theme.functionKey
    else if keyType == 'enter' then theme.enterKey
    else theme.alphabeticKey;
  },

  // 获取文本颜色
  getTextColor: function(themeName, type) {
    local theme = self.getTheme(themeName);
    if type == 'primary' || type == 'accent' then theme.text[type]
    else theme.text.secondary;
  },
}