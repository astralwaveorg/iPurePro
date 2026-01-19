local animation = import '../lib/animation.libsonnet';
local center = import '../lib/center.libsonnet';
local collectionData = import '../lib/collectionData.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local _hintSymbolsData = import '../lib/hintSymbolsData.libsonnet';
local others = import '../lib/others.libsonnet';
local swipeData = import '../lib/swipeData.libsonnet';
local toolbar = import '../lib/toolbar.libsonnet';
local utils = import '../lib/utils.libsonnet';


local hintSymbolsStyles = import '../lib/hintSymbolsStyles.libsonnet';
local swipeStyles = import '../lib/swipeStyles.libsonnet';

// 上下和下划的数据
local swipe_up = std.get(swipeData, 'number_swipe_up', {});
local swipe_down = std.get(swipeData, 'number_swipe_down', {});
local hintSymbolsData = std.get(_hintSymbolsData, 'number', {});


local createButton(params={}) =
  local isNumber = std.get(params, 'isNumber', true);
  std.prune({
    size: std.get(params, 'size'),
    bounds: std.get(params, 'bounds'),
    // params中没有isNumber: falsa和背景时，就是数字键背景，非数字键时，设置了背景就用设置的，没设置就默认 key+ButtonBackgroundStyle
    backgroundStyle: if isNumber then 'numberButtonBackgroundStyle' else std.get(params, 'backgroundStyle', 'systemButtonBackgroundStyle'),
    // 和背景是差不多的逻辑
    foregroundStyle:
      if isNumber then
        std.prune([
          if isNumber then 'number' + params.key + 'ButtonForegroundStyle' else params.key + 'ButtonForegroundStyle',
          if std.objectHas(swipe_up, params.key) then 'number' + params.key + 'ButtonUpForegroundStyle' else null,
          if std.objectHas(swipe_down, params.key) then 'number' + params.key + 'ButtonDownForegroundStyle' else null,
        ])
      else
        std.get(params, 'foregroundStyle', params.key + 'ButtonForegroundStyle'),

    action: std.get(params, 'action', { character: params.key }),
    repeatAction: std.get(params, 'repeatAction'),

    [if std.objectHas(swipe_up, params.key) then 'swipeUpAction']: swipe_up[params.key].action,
    [if std.objectHas(swipe_down, params.key) then 'swipeDownAction']: swipe_down[params.key].action,
    // [if isNumber then 'hintSymbolsStyle']: 'number' + params.key + 'ButtonHintSymbolsStyle',
    [if std.objectHas(hintSymbolsData, 'number' + params.key) then 'hintSymbolsStyle']: 'number' + params.key + 'ButtonHintSymbolsStyle',

    // 动画
    animation: [
      'ButtonScaleAnimation',
    ],
  });

local keyboard(theme) =
  {

    [if std.objectHas(others, '中文键盘方案') then 'rimeSchema']: others['中文键盘方案'],
    preeditHeight: others['竖屏']['preedit高度'],
    toolbarHeight: others['竖屏']['toolbar高度'],
    keyboardHeight: others['竖屏']['keyboard高度'],


    keyboardLayout: [
      {
        VStack: {
          style: 'VStackStyle1',
          subviews: [
            { Cell: 'collection' },
            { Cell: 'returnButton' },
          ],
        },
      },
      {
        VStack: {
          style: 'VStackStyle2',
          subviews: [
            { Cell: 'number1Button' },
            { Cell: 'number4Button' },
            { Cell: 'number7Button' },
            { Cell: 'symbolButton' },
          ],
        },
      },
      {
        VStack: {
          style: 'VStackStyle2',
          subviews: [
            { Cell: 'number2Button' },
            { Cell: 'number5Button' },
            { Cell: 'number8Button' },
            { Cell: 'number0Button' },
          ],
        },
      },
      {
        VStack: {
          style: 'VStackStyle2',
          subviews: [
            { Cell: 'number3Button' },
            { Cell: 'number6Button' },
            { Cell: 'number9Button' },
            { Cell: 'spaceButton' },
          ],
        },
      },
      {
        VStack: {
          style: 'VStackStyle1',
          subviews: [
            { Cell: 'equalButton' },
            { Cell: 'periodButton' },
            { Cell: 'backspaceButton' },
            { Cell: 'enterButton' },
          ],
        },
      },
    ],
    keyboardStyle: {
      insets: {
        top: 1,
      },
      // "backgroundStyle": "keyboardBackgroundStyle"
    },
    keyboardBackgroundStyle: {
      normalImage: {
        file: 'bg',
        image: 'IMG1',
      },
    },
    VStackStyle1: {
      size: {
        width: '29/183',
      },
    },
    VStackStyle2: {
      size: {
        width: '125/549',
      },
    },
    collection: {
      size: {
        height: '3/4',
      },
      backgroundStyle: 'collectionBackgroundStyle',
      insets: { left: 5, right: 3, top: 5, bottom: 3 },
      type: 'symbols',
      dataSource: 'symbols',
      cellStyle: 'collectionCellStyle',
      useRimeEngine: true,  // 符号列表经过rime处理
    },
    collectionBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: { left: 5, right: 3, top: 5, bottom: 3 },
      normalColor: color[theme]['符号键盘左侧collection背景颜色'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['符号键盘左侧collection背景下边缘颜色'],
    },

    collectionCellStyle: {
      backgroundStyle: 'collectionCellBackgroundStyle',
      foregroundStyle: 'collectionCellForegroundStyle',
    },
    collectionCellBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: { left: 5, right: 3, top: 5, bottom: 3 },
      highlightColor: 'ffffff',
      normalColor: 'ffffff00',
      cornerRadius: 7,
    },
    collectionCellForegroundStyle: {
      buttonStyleType: 'text',
      normalColor: color[theme]['collection前景颜色'],
      fontSize: fontSize['collection前景字体大小'],
      fontWeight: 0,
    },

    number1Button: createButton(
      params={ key: '1' }
    ),
    number4Button: createButton(
      params={ key: '4' }
    ),
    number7Button: createButton(
      params={ key: '7' }
    ),
    number2Button: createButton(
      params={ key: '2' }
    ),
    number5Button: createButton(
      params={ key: '5' }
    ),
    number8Button: createButton(
      params={ key: '8' }
    ),
    number0Button: createButton(
      params={ key: '0' }
    ),
    number3Button: createButton(
      params={ key: '3' }
    ),
    number6Button: createButton(
      params={ key: '6' }
    ),
    number9Button: createButton(
      params={ key: '9' }
    ),

    returnButton: createButton(
      params={
        key: 'return',
        action: 'returnLastKeyboard',
        isNumber: false,
        backgroundStyle: 'lanseButtonBackgroundStyle',
      }
    ),

    returnButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '返回',
        normalColor: color[theme]['个别功能前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        center: center['功能键前景文字偏移'],
      }
    ),


    symbolButton: createButton(
      params={
        key: 'symbol',
        action: { keyboardType: 'symbolic' },
        isNumber: false,
        backgroundStyle: 'numberButtonBackgroundStyle',
      }
    ),

    symbolButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '符',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'],
        center: { x: 0.5, y: 0.48 },  // 向上调整0.02
      }
    ),

    spaceButton: createButton(
      params={
        key: 'space',
        action: 'space',
        isNumber: false,
        backgroundStyle: 'numberButtonBackgroundStyle',
      }
    ),

    spaceButtonForegroundStyle: utils.makeSystemImageStyle(
      params={
        systemImageName: 'space',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'],
      }
    ),

    backspaceButton: createButton(
      params={
        key: 'backspace',
        action: 'backspace',
        repeatAction: 'backspace',
        isNumber: false,
      }
    ),

    backspaceButtonForegroundStyle: utils.makeSystemImageStyle(
      params={
        systemImageName: 'delete.left',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'],
        targetScale: 0.7,
        center: { y: 0.53 },
      }
    ),

    periodButton: createButton(
      params={
        key: 'period',
        action: { symbol: '.' },
        isNumber: false,
      }
    ),

    periodButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '.',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['数字键盘数字前景字体大小'],
      }
    ),

    equalButton: createButton(
      params={
        key: 'equal',
        action: {
          character: '=',
        },
        isNumber: false,
        center: center['功能键前景文字偏移'],
      }
    ),

    equalButtonForegroundStyle: utils.makeTextStyle(
      params={
        text: '=',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['collection前景字体大小'],
        fontWeight: 0,
      }
    ),

    enterButton: createButton(
      params={
        key: 'enter',
        action: 'enter',
        isNumber: false,
        backgroundStyle: 'enterButtonBlueBackgroundStyle',
      }
    ) + {
      backgroundStyle: [
        {
          styleName: 'enterButtonBlueBackgroundStyle',
          conditionKey: '$returnKeyType',
          conditionValue: [0, 2, 3, 5, 8, 10, 11],
        },
        {
          styleName: 'enterButtonBlueBackgroundStyle',
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
      // 按键通知
      notification: [
        'garyReturnKeyTypeNotification',
        'blueReturnKeyTypeNotification14',
        'blueReturnKeyTypeNotification6',
        'blueReturnKeyTypeNotification7',
        'blueReturnKeyTypeNotification9',
      ],
    },

    enterButtonForegroundStyle0: utils.makeSystemImageStyle(
      params={
        systemImageName: 'return.left',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'],
        center: center['功能键前景文字偏移'],
      }
    ),
    enterButtonForegroundStyle6: utils.makeSystemImageStyle(
      params={
        systemImageName: 'magnifyingglass',
        normalColor: color[theme]['长按选中字体颜色'],
        highlightColor: color[theme]['长按非选中字体颜色'],
        fontSize: fontSize['按键前景文字大小'],
        center: center['功能键前景文字偏移'],
      }
    ),

    enterButtonForegroundStyle7: utils.makeSystemImageStyle(
      params={
        systemImageName: 'paperplane',
        normalColor: color[theme]['长按选中字体颜色'],
        highlightColor: color[theme]['长按非选中字体颜色'],
        fontSize: fontSize['按键前景文字大小'],
        center: center['功能键前景文字偏移'],
      }
    ),

    enterButtonForegroundStyle14: utils.makeSystemImageStyle(
      params={
        systemImageName: 'arrowshape.turn.up.forward',
        normalColor: color[theme]['长按选中字体颜色'],
        highlightColor: color[theme]['长按非选中字体颜色'],
        fontSize: fontSize['按键前景文字大小'],
        center: center['功能键前景文字偏移'],
      }
    ),

    enterButtonForegroundStyle9: utils.makeSystemImageStyle(
      params={
        systemImageName: 'checkmark.app.stack',
        normalColor: color[theme]['长按选中字体颜色'],
        highlightColor: color[theme]['长按非选中字体颜色'],
        fontSize: fontSize['按键前景文字大小'],
        center: center['功能键前景文字偏移'],
      }
    ),

    enterButtonBlueBackgroundStyle: utils.makeGeometryStyle(
      params={
        buttonStyleType: 'geometry',
        insets: { top: 4, left: 3, bottom: 4, right: 3 },
        normalColor: color[theme]['enter键背景(绿色)'],
        highlightColor: color[theme]['字母键背景颜色-普通'],
        cornerRadius: 7,
        normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
        highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
      }
    ),
    // 回车通知（前景 0）
    garyReturnKeyTypeNotification: {
      notificationType: 'returnKeyType',
      returnKeyType: [0, 2, 3, 5, 8, 10, 11],
      backgroundStyle: 'enterButtonBlueBackgroundStyle',
      foregroundStyle: 'enterButtonForegroundStyle0',
    },

    // 蓝色回车通知（按前景细分）
    blueReturnKeyTypeNotification14: {
      notificationType: 'returnKeyType',
      returnKeyType: [1, 4],
      backgroundStyle: 'enterButtonBlueBackgroundStyle',
      foregroundStyle: 'enterButtonForegroundStyle14',
    },
    blueReturnKeyTypeNotification6: {
      notificationType: 'returnKeyType',
      returnKeyType: [6],
      backgroundStyle: 'enterButtonBlueBackgroundStyle',
      foregroundStyle: 'enterButtonForegroundStyle6',
    },
    blueReturnKeyTypeNotification7: {
      notificationType: 'returnKeyType',
      returnKeyType: [7],
      backgroundStyle: 'enterButtonBlueBackgroundStyle',
      foregroundStyle: 'enterButtonForegroundStyle7',
    },
    blueReturnKeyTypeNotification9: {
      notificationType: 'returnKeyType',
      returnKeyType: [9],
      backgroundStyle: 'enterButtonBlueBackgroundStyle',
      foregroundStyle: 'enterButtonForegroundStyle9',
    },


    lanseButtonBackgroundStyle: utils.makeGeometryStyle(
      params={
        insets: { top: 4, left: 3, bottom: 4, right: 3 },
        normalColor: color[theme]['enter键背景(绿色)'],
        highlightColor: color[theme]['字母键背景颜色-普通'],
        cornerRadius: 7,
        normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
        highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
      }
    ),

    numberButtonBackgroundStyle: utils.makeGeometryStyle(
      params={
        insets: { top: 4, left: 3, bottom: 4, right: 3 },
        normalColor: color[theme]['字母键背景颜色-普通'],
        highlightColor: color[theme]['字母键背景颜色-高亮'],
        cornerRadius: 7,
        normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
        highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
      }
    ),

    systemButtonBackgroundStyle: utils.makeGeometryStyle(
      params={
        insets: { top: 4, left: 3, bottom: 4, right: 3 },
        normalColor: color[theme]['功能键背景颜色-普通'],
        highlightColor: color[theme]['功能键背景颜色-高亮'],
        cornerRadius: 7,
        normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
        highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
      }
    ),

    ButtonScaleAnimation: animation['26键按键动画'],
    alphabeticHintSymbolsBackgroundStyle: hintSymbolsStyles['长按背景样式'],
    alphabeticHintSymbolsSelectedStyle: hintSymbolsStyles['长按选中背景样式'],

    // 左侧符号列表数据来源
    symbols: collectionData.numericSymbols,
  };

{
  new(theme):
    keyboard(theme) +
    swipeStyles.makeSwipeStyles(theme, {
      swipe_up: swipe_up,
      swipe_down: swipe_down,
      type: 'number',
      orientation: 'portrait',
    }) +
    hintSymbolsStyles.getStyle(theme, hintSymbolsData) +
    toolbar.getToolBar(theme, 'portrait') +
    utils.genNumberStyles(theme),

  // 导出keyboard给横屏用
  keyboard: keyboard,
}