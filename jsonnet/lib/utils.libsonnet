local center = import 'center.libsonnet';
local color = import 'color.libsonnet';
local fontSize = import 'fontSize.libsonnet';

// 文字样式
local makeTextStyle(params) = {
  buttonStyleType: 'text',
  text: std.get(params, 'text', ''),
  fontSize: std.get(params, 'fontSize', 18),
  normalColor: std.get(params, 'normalColor', '#000000'),
  highlightColor: std.get(params, 'highlightColor', '#000000'),
  center: std.get(params, 'center', { x: 0.5, y: 0.5 }),
  insets: std.get(params, 'insets', {}),
  fontWeight: std.get(params, 'fontWeight', 0),
};

// sf符号样式
local makeSystemImageStyle(params) = {
  buttonStyleType: 'systemImage',
  systemImageName: std.get(params, 'systemImageName', ''),
  fontSize: std.get(params, 'fontSize', 18),
  normalColor: std.get(params, 'normalColor', '#000000'),
  highlightColor: std.get(params, 'highlightColor', '#000000'),
  center: std.get(params, 'center', { x: 0.5, y: 0.5 }),
  targetScale: std.get(params, 'targetScale', 1),
};

// 图片样式
local makeImageStyle(params) = {
  buttonStyleType: 'fileImage',
  contentMode: std.get(params, 'contentMode', 'center'),
  insets: std.get(params, 'insets', {}),
  normalImage: std.get(params, 'normalImage', {}),
  highlightImage: std.get(params, 'highlightImage', {}),
  targetScale: std.get(params, 'targetScale', 1),
};

// 几何样式
local makeGeometryStyle(params) = {
  buttonStyleType: 'geometry',
  insets: std.get(params, 'insets', { top: 3, left: 3, bottom: 4, right: 3 }),
  normalColor: std.get(params, 'normalColor', '#FFFFFF'),
  highlightColor: std.get(params, 'highlightColor', '#ABB0BA'),
  cornerRadius: std.get(params, 'cornerRadius', 7),
  normalLowerEdgeColor: std.get(params, 'normalLowerEdgeColor', '#000000'),
  highlightLowerEdgeColor: std.get(params, 'highlightLowerEdgeColor', '#000000'),
  normalShadowColor: std.get(params, 'normalShadowColor', null),
  normalShadowOffset: std.get(params, 'normalShadowOffset', null),
};

// 气泡样式
local makeBubbleStyle(params) = {
  buttonStyleType: 'geometry',
  normalColor: std.get(params, 'normalColor', '#FFFFFF'),
  highlightColor: std.get(params, 'highlightColor', '#FFFFFF'),
  cornerRadius: std.get(params, 'cornerRadius', 7),
  shadowColor: std.get(params, 'shadowColor', '#000000'),
  shadowOffset: std.get(params, 'shadowOffset', { x: 0, y: 5 }),
};

// 26键字母样式生成
local keyMap = {
  'q': 'q', 'w': 'w', 'e': 'e', 'r': 'r', 't': 't', 'y': 'y', 'u': 'u', 'i': 'i', 'o': 'o', 'p': 'p',
  'a': 'a', 's': 's', 'd': 'd', 'f': 'f', 'g': 'g', 'h': 'h', 'j': 'j', 'k': 'k', 'l': 'l',
  'z': 'z', 'x': 'x', 'c': 'c', 'v': 'v', 'b': 'b', 'n': 'n', 'm': 'm',
};

local genAlphabeticStyles(theme) =
  {
    [keyName + 'ButtonForegroundStyle']: makeTextStyle(
      params={
        text: std.asciiLower(keyMap[keyName]),
        fontSize: fontSize['按键前景英文大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        center: center['26键中文前景偏移'],
      }
    )
    for keyName in std.objectFields(keyMap)
  } + {
    [keyName + 'ButtonUppercasedStateForegroundStyle']: makeTextStyle(
      params={
        text: std.asciiUpper(keyMap[keyName]),
        fontSize: fontSize['按键前景英文大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        center: center['26键中文前景偏移'],
      }
    )
    for keyName in std.objectFields(keyMap)
  };

local genPinyinStyles(theme) =
  {
    [keyName + 'ButtonForegroundStyle']: makeTextStyle(
      params={
        text: std.asciiLower(keyMap[keyName]),
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        center: center['26键中文前景偏移'],
      }
    )
    for keyName in std.objectFields(keyMap)
  } + {
    [keyName + 'ButtonUppercasedStateForegroundStyle']: makeTextStyle(
      params={
        text: std.asciiUpper(keyMap[keyName]),
        fontSize: fontSize['按键前景英文大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        center: center['26键中文前景偏移'],
      }
    )
    for keyName in std.objectFields(keyMap)
  };

local genNumberStyles(theme) =
  {
    ['number' + keyName + 'ButtonForegroundStyle']: makeTextStyle(
      params={
        text: keyName,
        fontSize: fontSize['数字键盘数字前景字体大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        center: center['数字键盘数字前景偏移'],
      }
    )
    for keyName in ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
  };

local genHintStyles(theme) =
  {
    [keyName + 'ButtonHintForegroundStyle']: makeTextStyle(
      params={
        text: keyName,
        fontSize: fontSize['划动气泡前景文字大小'],
        normalColor: color[theme]['按下气泡文字颜色'],
        highlightColor: color[theme]['按下气泡文字颜色'],
        center: center['划动气泡文字偏移'],
      }
    )
    for keyName in ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
  } + {
    [keyName + 'ButtonSwipeUpHintForegroundStyle']: makeTextStyle(
      params={
        text: keyName,
        fontSize: fontSize['划动气泡前景文字大小'],
        normalColor: color[theme]['按下气泡文字颜色'],
        highlightColor: color[theme]['按下气泡文字颜色'],
        center: center['划动气泡文字偏移'],
      }
    )
    for keyName in ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
  } + {
    [keyName + 'ButtonSwipeDownHintForegroundStyle']: makeTextStyle(
      params={
        text: keyName,
        fontSize: fontSize['划动气泡前景文字大小'],
        normalColor: color[theme]['按下气泡文字颜色'],
        highlightColor: color[theme]['按下气泡文字颜色'],
        center: center['划动气泡文字偏移'],
      }
    )
    for keyName in ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
  };

{
  makeTextStyle: makeTextStyle,
  makeSystemImageStyle: makeSystemImageStyle,
  makeImageStyle: makeImageStyle,
  makeGeometryStyle: makeGeometryStyle,
  makeBubbleStyle: makeBubbleStyle,
  genAlphabeticStyles: genAlphabeticStyles,
  genPinyinStyles: genPinyinStyles,
  genNumberStyles: genNumberStyles,
  genHintStyles: genHintStyles,
}