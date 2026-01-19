// 核心常量定义
{
  // 按钮尺寸常量
  BUTTON: {
    INSETS: { top: 3.5, left: 2.5, bottom: 3.5, right: 2.5 },
    CORNER_RADIUS: 7,
    SCALE: 0.87,
    HINT_CORNER_RADIUS: 7,
    HINT_SHADOW_OFFSET: { x: 0, y: 5 },
  },
  
  // 尺寸常量
  DIMENSIONS: {
    KEYBOARD_HEIGHT: {
      PORTRAIT: '285/667',
      LANDSCAPE: '285/667',
    },
    TOOLBAR_HEIGHT: {
      PORTRAIT: '44/667',
      LANDSCAPE: '44/667',
    },
    PREEDIT_HEIGHT: {
      PORTRAIT: '36/667',
      LANDSCAPE: '36/667',
    },
  },
  
  // 动画常量
  ANIMATION: {
    BUTTON_SCALE: {
      type: 'scale',
      isAutoReverse: true,
      pressDuration: 60,
      releaseDuration: 80,
      scale: 0.87,
    },
  },
  
  // 布局常量
  LAYOUT: {
    COLUMN_RATIOS: {
      PORTRAIT: {
        LEFT: '29/183',
        MIDDLE: '125/183',
        RIGHT: '29/183',
      },
      LANDSCAPE: {
        LEFT: '2/5',
        MIDDLE: '1/5',
        RIGHT: '2/5',
      },
    },
  },
  
  // 字体大小常量
  FONT_SIZE: {
    CANDIDATE: {
      SELECTED: 18,
      UNSELECTED: 16,
      COMMENT: 14,
      PREEDIT: 16,
    },
    BUTTON: {
      TEXT: 18,
      ENGLISH: 19,
      SYMBOL: 14,
    },
    SWIPE: {
      PORTRAIT: 12,
      LANDSCAPE: 9,
    },
    TOOLBAR: {
      SYMBOL: 16,
      TEXT: 13,
    },
    NUMBER_KEY: 20,
    PANEL: {
      TEXT: 12,
      SYMBOL: 16,
    },
  },
  
  // 位置偏移常量
  OFFSET: {
    BUTTON_TEXT: { x: 0.5, y: 0.55 },
    BUTTON_HINT: { x: 0.5, y: 0.6 },
    FUNCTION_KEY: { x: 0.5, y: 0.5 },
    SWIPE: {
      PORTRAIT: {
        UP: { x: 0.25, y: 0.28 },
        DOWN: { x: 0.75, y: 0.26 },
        UP_SYMBOL: { x: 0.25, y: 0.68 },
        DOWN_SYMBOL: { x: 0.75, y: 0.66 },
      },
      LANDSCAPE: {
        UP: { x: 0.15, y: 0.15 },
        DOWN: { x: 0.85, y: 0.85 },
        UP_SYMBOL: { x: 0.15, y: 0.15 },
        DOWN_SYMBOL: { x: 0.85, y: 0.85 },
      },
    },
    NUMBER_KEY: { x: 0.5, y: 0.48 },
    SYMBOL_KEY: { x: 0.5, y: 0.48 },
    TOOLBAR: { x: 0.5, y: 0.55 },
    BUBBLE: {
      TEXT: { x: 0.5, y: 0.6 },
      SYMBOL: { x: 0.5, y: 0.5 },
    },
    PANEL: {
      TEXT: { y: 0.7 },
      SYMBOL: { y: 0.4 },
    },
  },
  
  // 按键宽度比例（横屏）
  LANDSCAPE_BUTTON_WIDTH: {
    NORMAL: '146/784',
    WIDE: '200/784',
    SHIFT: '200/784',
    BACKSPACE: '200/784',
    EN_ZH: '104/784',
    SYMBOL: '104/784',
    NUMBER: '105.6/784',
    SPACE: '200/784',
    SPACE_RIGHT: '104/784',
    ENTER: '346/784',
    V_B_N: '209.6/784',
  },
  
  // 按键宽度比例（竖屏）
  PORTRAIT_BUTTON_WIDTH: {
    NORMAL: 0.15,
    SHIFT: 0.15,
    BACKSPACE: 0.15,
    EN_ZH: 0.11,
    SYMBOL: 0.12,
    NUMBER: 0.12,
    SPACE: 0.37,
    SPACE_RIGHT: 0.10,
    ENTER: 0.18,
  },
}