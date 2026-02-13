local center = import 'center.libsonnet';
local color = import 'color.libsonnet';
local fontSize = import 'fontSize.libsonnet';
local pickColors = function(overridesColor, theme)
  if overridesColor == {} then {}
  else {
    normalColor: overridesColor[theme].normalColor,
    highlightColor: overridesColor[theme].highlightColor,
  };

local colorsOrDefault = function(overrides, theme)
  local overridesColor = std.get(overrides, 'color', {});
  local picked = pickColors(overridesColor, theme);
  if picked != {} then picked else { normalColor: color[theme]['划动字符颜色'], highlightColor: color[theme]['划动字符颜色'] };

local defaultCenter = function(direction, type, orientation)
  local portraitMap = {
    up: {
      pinyin: center['上划文字偏移'],
      number: center['数字键盘上划文字偏移'],
      cn9: center['数字键盘上划文字偏移'],
    },
    down: {
      pinyin: center['下划文字偏移'],
      number: center['数字键盘下划文字偏移'],
      cn9: center['数字键盘下划文字偏移'],
    },
  };

  local landscapeMap = {
    up: {
      pinyin: { x: 0.2, y: 0.22 },
      number: { x: 0.2, y: 0.22 },
      cn9: { x: 0.2, y: 0.22 },
    },
    down: {
      pinyin: { x: 0.85, y: 0.82 },
      number: { x: 0.85, y: 0.82 },
      cn9: { x: 0.85, y: 0.82 },
    },
  };

  if orientation == 'landscape' then landscapeMap[direction][type]
  else portraitMap[direction][type];


local defaultFontSize = function(direction, orientation)
  if orientation == 'landscape' then
    if direction == 'up' then fontSize['横屏上划文字大小'] else fontSize['横屏下划文字大小']
  else
    if direction == 'up' then fontSize['上划文字大小'] else fontSize['下划文字大小']
  ;

local makeTextStyle = function(theme, label, direction, type, orientation, overrides={})
  local c = colorsOrDefault(overrides, theme);
  {
    buttonStyleType: 'text',
    text: label.text,
    fontSize: std.get(overrides, 'fontSize', defaultFontSize(direction, orientation)),
    fontWeight: std.get(overrides, 'fontWeight', 'medium'),
    normalColor: c.normalColor,
    highlightColor: c.highlightColor,
    center: std.get(overrides, 'center', defaultCenter(direction, type, orientation)),
    insets: std.get(overrides, 'insets', {}),
  };

local makeSystemImageStyle = function(theme, label, direction, type, orientation, overrides={})
  local c = colorsOrDefault(overrides, theme);
  {
    buttonStyleType: 'systemImage',
    systemImageName: label.systemImageName,
    fontSize: std.get(overrides, 'fontSize', defaultFontSize(direction, orientation)),
    fontWeight: std.get(overrides, 'fontWeight', 'medium'),
    normalColor: c.normalColor,
    highlightColor: c.highlightColor,
    center: std.get(overrides, 'center', defaultCenter(direction, type, orientation)),
    insets: std.get(overrides, 'insets', {}),
  };

// 根据 key 生成样式名称
local styleName = function(type, key, direction)
  // 数字类型且单字符的键使用特殊命名规则
  if type == 'number' && std.length(key) == 1
  then 'number' + key + 'Button' + (if direction == 'up' then 'Up' else 'Down') + 'ForegroundStyle'
  else key + 'Button' + (if direction == 'up' then 'Up' else 'Down') + 'ForegroundStyle';

local makeForegroundStyle = function(key, direction, theme, type, orientation, data)
  local label = std.get(data, 'label', {});

  // 根据标签类型生成相应的前景样式
  if std.objectHas(label, 'text') then
    { [styleName(type, key, direction)]: makeTextStyle(theme, label, direction, type, orientation, data) }
  else if std.objectHas(label, 'systemImageName') then
    { [styleName(type, key, direction)]: makeSystemImageStyle(theme, label, direction, type, orientation, data) }
  else {};

// 通用的滑动气泡样式生成函数（上滑和下滑共用）
local makeSwipeHintForegroundStyle = function(key, direction, theme, type, orientation, data)
  local label = std.get(data, 'label', {});
  // 根据方向选择气泡字体大小
  local bubbleFontSize = if orientation == 'landscape' then fontSize['横屏滑动气泡文字大小'] else fontSize['竖屏滑动气泡文字大小'];

  // 为单字符键生成特殊的滑动提示样式
  if std.length(key) == 1 && std.objectHas(data, 'label') then
    if std.objectHas(label, 'text') then
      {
        [key + 'ButtonSwipe' + (if direction == 'up' then 'Up' else 'Down') + 'HintForegroundStyle']:
          makeTextStyle(
            theme,
            label,
            direction,
            type,
            orientation,
            data + {
              center: center['划动气泡文字偏移'],
              fontSize: bubbleFontSize,
            }
          ),
      }
    else if std.objectHas(label, 'systemImageName') then
      {
        [key + 'ButtonSwipe' + (if direction == 'up' then 'Up' else 'Down') + 'HintForegroundStyle']:
          makeSystemImageStyle(
            theme,
            label,
            direction,
            type,
            orientation,
            data + {
              center: center['划动气泡sf符号偏移'],
              fontSize: bubbleFontSize,
            }
          ),
      }
    else {}
  else {};


local processDirection = function(dirData, direction, theme, type, orientation)
  // 生成基本前景样式
  std.foldl(
    function(acc, k) acc + makeForegroundStyle(k, direction, theme, type, orientation, dirData[k]),
    std.objectFields(dirData),
    {}
  ) +
  // 气泡显示（上滑和下滑都生成）
  if type == 'pinyin' then
    std.foldl(
      function(acc, k) acc + makeSwipeHintForegroundStyle(k, direction, theme, type, orientation, dirData[k]),
      std.objectFields(dirData),
      {}
    )
  else {};


// params 结构: { swipe_up: {...}, swipe_down: {...}, type: 'pinyin'|'number'|'cn9', orientation: 'portrait'|'landscape' }
local makeSwipeStyles = function(theme, params)
  local swipe_up = std.get(params, 'swipe_up', {});
  local swipe_down = std.get(params, 'swipe_down', {});
  local type = std.get(params, 'type', '');
  local orientation = std.get(params, 'orientation', 'portrait');

  // 处理上滑和下滑数据，生成相应的样式
  processDirection(swipe_up, 'up', theme, type, orientation) +
  processDirection(swipe_down, 'down', theme, type, orientation);

// 导出主函数
{
  makeSwipeStyles: makeSwipeStyles,
}
