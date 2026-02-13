local alphabetic = import "./keyboards/alphabetic_26.jsonnet";
local numeric = import "./keyboards/numeric_9.jsonnet";
local pinyin = import "./keyboards/pinyin_26.jsonnet";
local symbolic = import "./keyboards/symbolic.jsonnet";
local panel = import "./panel.jsonnet";

{
  config: {
    author: "sicen",
    name: "iPure·Pro",
    version: "2.0",
  },
  
  // 字母键盘测试
  alphabetic_light_portrait: alphabetic.new("light", "portrait"),
  alphabetic_dark_portrait: alphabetic.new("dark", "portrait"),
  alphabetic_light_landscape: alphabetic.new("light", "landscape"),
  alphabetic_dark_landscape: alphabetic.new("dark", "landscape"),
  
  // 数字键盘测试
  numeric_light_portrait: numeric.new("light", "portrait"),
  numeric_dark_portrait: numeric.new("dark", "portrait"),
  numeric_light_landscape: numeric.new("light", "landscape"),
  numeric_dark_landscape: numeric.new("dark", "landscape"),
  
  // 拼音键盘测试
  pinyin_light_portrait: pinyin.new("light", "portrait"),
  pinyin_dark_portrait: pinyin.new("dark", "portrait"),
  pinyin_light_landscape: pinyin.new("light", "landscape"),
  pinyin_dark_landscape: pinyin.new("dark", "landscape"),
  
  // 符号键盘测试
  symbolic_light_portrait: symbolic.new("light", "portrait"),
  symbolic_dark_portrait: symbolic.new("dark", "portrait"),
  symbolic_light_landscape: symbolic.new("light", "landscape"),
  symbolic_dark_landscape: symbolic.new("dark", "landscape"),
  
  // 面板测试
  panel_light_portrait: panel.new("light", "portrait"),
  panel_dark_portrait: panel.new("dark", "portrait"),
  panel_light_landscape: panel.new("light", "landscape"),
  panel_dark_landscape: panel.new("dark", "landscape"),
}