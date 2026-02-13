// 工具函数库
local constants = import '../core/constants.libsonnet';
local theme = import '../core/theme.libsonnet';

// 创建文本样式
local makeTextStyle = function(text, fontSize, color, center, fontWeight='medium') {
    buttonStyleType: 'text',
    text: text,
    fontSize: fontSize,
    fontWeight: fontWeight,
    normalColor: color,
    highlightColor: color,
    center: center,
};

// 创建SF符号样式
local makeSymbolStyle = function(symbolName, fontSize, color, center, fontWeight='medium') {
    buttonStyleType: 'systemImage',
    systemImageName: symbolName,
    fontSize: fontSize,
    fontWeight: fontWeight,
    normalColor: color,
    highlightColor: color,
    center: center,
};

// 创建几何样式
local makeGeometryStyle = function(color, cornerRadius, insets, lowerEdgeColor) {
    buttonStyleType: 'geometry',
    normalColor: color,
    highlightColor: color,
    cornerRadius: cornerRadius,
    insets: insets,
    normalLowerEdgeColor: lowerEdgeColor,
    highlightLowerEdgeColor: lowerEdgeColor,
};

// 创建图片样式
local makeImageStyle = function(file, image, contentMode, insets) {
    buttonStyleType: 'fileImage',
    contentMode: contentMode,
    normalImage: { file: file, image: image },
    insets: insets,
};

// 创建按键样式
local makeButtonStyle = function(themeName, keyType, state) {
  local themeData = theme.getTheme(themeName);
  local keyData = themeData[keyType];
  local suffix = if state == 'highlight' then 'Highlight' else 'Normal';
  makeGeometryStyle(
    keyData["background" + suffix],
    constants.BUTTON.CORNER_RADIUS,
    constants.BUTTON.INSETS,
    keyData["backgroundLowerEdge" + suffix]
  )
};

// 创建按键前景样式
local makeButtonForegroundStyle = function(text, fontSize, color, center) {
  makeTextStyle(text, fontSize, color, center);
};

// 创建按键前景符号样式
local makeButtonForegroundSymbolStyle = function(symbol, fontSize, color, center) {
  makeSymbolStyle(symbol, fontSize, color, center);
};

// 批量生成26键样式
local generate26KeyStyles = function(theme, prefix) {
  std.foldl(
    function(acc, key) {
      local keyUpper = std.asciiUpper(key);
      acc + {
        [prefix + key + 'ButtonForegroundStyle']: makeButtonForegroundStyle(
          key,
          constants.FONT_SIZE.BUTTON.TEXT,
          theme.getTheme(theme).alphabeticKey.textNormal,
          constants.OFFSET.BUTTON_TEXT
        ),
        [prefix + key + 'ButtonUppercasedStateForegroundStyle']: makeButtonForegroundStyle(
          keyUpper,
          constants.FONT_SIZE.BUTTON.TEXT,
          theme.getTheme(theme).alphabeticKey.textNormal,
          constants.OFFSET.BUTTON_TEXT
        ),
        [prefix + key + 'ButtonHintForegroundStyle']: makeButtonForegroundStyle(
          keyUpper,
          constants.FONT_SIZE.BUTTON.TEXT * 1.5,
          theme.getTheme(theme).longPress.unselected,
          constants.OFFSET.BUTTON_HINT
        ),
      };
    },
    ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'z', 'x', 'c', 'v', 'b', 'n', 'm'],
    {}
  );
};

// 批量生成数字键样式
local generateNumberKeyStyles = function(theme) {
  std.foldl(
    function(acc, key) {
      acc + {
        ['number' + key + 'ButtonForegroundStyle']: makeButtonForegroundStyle(
          key,
          constants.FONT_SIZE.NUMBER_KEY,
          theme.getTheme(theme).alphabeticKey.textNormal,
          constants.OFFSET.NUMBER_KEY
        ),
      };
    },
    ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
    {}
  );
};

// 导出工具函数
{
  makeTextStyle: makeTextStyle,
  makeSymbolStyle: makeSymbolStyle,
  makeGeometryStyle: makeGeometryStyle,
  makeImageStyle: makeImageStyle,
  makeButtonStyle: makeButtonStyle,
  makeButtonForegroundStyle: makeButtonForegroundStyle,
  makeButtonForegroundSymbolStyle: makeButtonForegroundSymbolStyle,
  generate26KeyStyles: generate26KeyStyles,
  generateNumberKeyStyles: generateNumberKeyStyles,
}
