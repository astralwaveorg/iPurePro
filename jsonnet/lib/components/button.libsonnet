// 按键组件库
local constants = import '../core/constants.libsonnet';
local utils = import '../core/utils.libsonnet';
local theme = import '../core/theme.libsonnet';

// 创建基础按键
local createBaseButton = function(key, size, action, isLetter=true) {
  std.prune({
    key: key,
    size: size,
    action: action,
    backgroundStyle: if isLetter then 'alphabeticBackgroundStyle' else 'systemButtonBackgroundStyle',
    animation: ['ButtonScaleAnimation'],
  });
};

// 创建字母按键
local createLetterButton = function(key, size) {
  createBaseButton(key, size, { character: key }, true);
};

// 创建功能按键
local createFunctionButton = function(key, size, action) {
  createBaseButton(key, size, action, false);
};

// 创建回车按键
local createEnterButton = function(size) {
  createBaseButton('enter', size, 'enter', false) + {
    backgroundStyle: [
      {
        styleName: 'systemButtonBackgroundStyle',
        conditionKey: '$returnKeyType',
        conditionValue: [0, 2, 3, 5, 8, 10, 11],
      },
      {
        styleName: 'enterButtonGreenBackgroundStyle',
        conditionKey: '$returnKeyType',
        conditionValue: [1, 4, 6, 7, 9],
      },
    ],
    foregroundStyle: [
      {
        styleName: 'enterButtonForegroundStyle0',
        conditionKey: '$returnKeyType',
        conditionValue: [0, 2, 3, 5, 8, 10, 11],
      },
      {
        styleName: 'enterButtonForegroundStyle14',
        conditionKey: '$returnKeyType',
        conditionValue: [1, 4],
      },
      {
        styleName: 'enterButtonForegroundStyle6',
        conditionKey: '$returnKeyType',
        conditionValue: [6],
      },
      {
        styleName: 'enterButtonForegroundStyle7',
        conditionKey: '$returnKeyType',
        conditionValue: [7],
      },
      {
        styleName: 'enterButtonForegroundStyle9',
        conditionKey: '$returnKeyType',
        conditionValue: [9],
      },
    ],
    notification: [
      'garyReturnKeyTypeNotification',
      'blueReturnKeyTypeNotification14',
      'blueReturnKeyTypeNotification6',
      'blueReturnKeyTypeNotification7',
      'blueReturnKeyTypeNotification9',
    ],
  };
};

// 创建Shift按键
local createShiftButton = function(size) {
  createBaseButton('shift', size, 'shift', false);
};

// 创建删除按键
local createBackspaceButton = function(size) {
  createBaseButton('backspace', size, 'backspace', false) + {
    repeatAction: 'backspace',
  };
};

// 创建空格按键
local createSpaceButton = function(size, action) {
  createBaseButton('space', size, action, false);
};

// 导出按键组件
{
  createBaseButton: createBaseButton,
  createLetterButton: createLetterButton,
  createFunctionButton: createFunctionButton,
  createEnterButton: createEnterButton,
  createShiftButton: createShiftButton,
  createBackspaceButton: createBackspaceButton,
  createSpaceButton: createSpaceButton,
}