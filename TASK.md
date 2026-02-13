# iPure·Pro v2 重构任务清单

> **项目目标**：将现有的 iPure·Pro 皮肤配置重构为易维护、结构清晰的新架构
> **重构方式**：在 `jsonnet/v2/` 子目录中完全重构，不修改现有代码
> **验证标准**：新旧架构生成的 YAML 文件完全一致

---

## 📋 项目概述

### 当前架构问题
1. **数据分散**：配置分布在 15+ 个 libsonnet 文件中
2. **重复代码**：新旧两套架构并存，大量重复配置
3. **命名不一致**：中英文混用，键名不规范
4. **依赖混乱**：文件间存在复杂的交叉引用
5. **维护困难**：修改一个功能需要改动多个文件

### 新架构目标
1. **单一数据源**：所有配置集中在 `config/` 目录
2. **清晰分层**：config（配置）、data（数据）、lib（工具）、keyboards（键盘）
3. **统一命名**：使用英文命名，遵循最佳实践
4. **易于维护**：修改功能只需改一处
5. **完全兼容**：输出与旧架构 100% 一致

---

## 📁 新架构目录结构

```
jsonnet/v2/
├── main.jsonnet                    # 主入口，生成所有键盘配置
│
├── config/                         # 🎯 配置中心（所有静态配置）
│   ├── index.libsonnet            # 统一导出所有配置
│   ├── theme.libsonnet            # 主题配置（亮色/暗色）
│   ├── dimensions.libsonnet       # 尺寸配置（按钮、字体、偏移）
│   ├── animation.libsonnet        # 动画配置
│   └── others.libsonnet           # 其他配置（高度、方案）
│
├── data/                          # 💾 数据中心（所有动态数据）
│   ├── index.libsonnet            # 统一导出所有数据
│   ├── swipe.libsonnet            # 滑动操作数据
│   ├── hint.libsonnet             # 长按提示数据
│   ├── collection.libsonnet       # 集合数据
│   └── toolbar.libsonnet          # 工具栏数据
│
├── lib/                           # 🔧 工具库（无状态纯函数）
│   ├── index.libsonnet            # 统一导出所有工具函数
│   ├── style.libsonnet            # 样式生成函数
│   ├── utils.libsonnet            # 通用工具函数
│   └── layout.libsonnet           # 布局计算函数
│
└── keyboards/                     # ⌨️ 键盘定义（使用新架构）
    ├── index.libsonnet            # 统一导出所有键盘
    ├── pinyin_26.jsonnet          # 拼音键盘（26键）
    ├── alphabetic_26.jsonnet      # 字母键盘（26键）
    ├── numeric_9.jsonnet          # 数字键盘（9键，支持竖屏/横屏）
    ├── symbolic.jsonnet           # 符号键盘
    └── panel.jsonnet              # 面板键盘（浮动模式）
```

---

## 📊 功能清单

### 支持的键盘类型
- [x] 拼音键盘（pinyin_26）- 中文输入，26键布局
- [x] 字母键盘（alphabetic_26）- 英文输入，26键布局
- [x] 数字键盘（numeric_9）- 数字输入，9键布局
- [x] 符号键盘（symbolic）- 符号输入
- [x] 面板键盘（panel）- 浮动模式键盘

### 支持的设备方向
- [x] 竖屏模式（portrait）- iPhone 和 iPad
- [x] 横屏模式（landscape）- iPhone 和 iPad
- [x] 浮动模式（floating）- iPad

### 支持的主题
- [x] 亮色主题（light）
- [x] 暗色主题（dark）

### 交互功能
- [x] 点击输入
- [x] 上滑操作（swipeUp）
- [x] 下滑操作（swipeDown）
- [x] 长按提示（hintSymbols）
- [x] 按键动画（animation）
- [x] 通知系统（notification）

### 特殊功能
- [x] Shift 键切换（大写/小写/锁定）
- [x] 智能回车键（根据输入框类型变化）
- [x] 中英文切换
- [x] 工具栏功能
- [x] 集合视图（符号列表、候选栏）

---

## 🎯 详细任务清单

### 阶段 1：准备和分析

#### 1.1 项目分析
- [x] 阅读官方文档（结构、布局、样式、动作、动画、通知、集合、预编辑）
- [x] 分析现有项目结构
- [x] 识别所有配置项
- [x] 识别重复代码
- [x] 识别未使用配置
- [ ] 创建 TASK.md（本文件）
- [ ] 创建 .iflowignore

#### 1.2 设计新架构
- [ ] 设计配置中心结构
- [ ] 设计数据中心结构
- [ ] 设计工具库结构
- [ ] 设计键盘文件结构
- [ ] 定义命名规范

### 阶段 2：创建基础结构

#### 2.1 创建目录结构
- [ ] 创建 `jsonnet/v2/` 目录
- [ ] 创建 `jsonnet/v2/config/` 目录
- [ ] 创建 `jsonnet/v2/data/` 目录
- [ ] 创建 `jsonnet/v2/lib/` 目录
- [ ] 创建 `jsonnet/v2/keyboards/` 目录

#### 2.2 创建索引文件
- [ ] 创建 `config/index.libsonnet`
- [ ] 创建 `data/index.libsonnet`
- [ ] 创建 `lib/index.libsonnet`
- [ ] 创建 `keyboards/index.libsonnet`

### 阶段 3：迁移配置中心

#### 3.1 主题配置（theme.libsonnet）
从 `lib/color.libsonnet` 迁移：
- [ ] 亮色主题
  - [ ] 字母键背景（普通/高亮）
  - [ ] 功能键背景（普通/高亮）
  - [ ] 回车键背景（绿色）
  - [ ] 气泡颜色（背景/边缘/高亮）
  - [ ] 底边缘颜色（普通/高亮）
  - [ ] 长按颜色（选中/非选中字体、选中背景、阴影、背景）
  - [ ] 候选字体颜色（选中/未选中字体、选中背景）
  - [ ] 工具栏颜色（按键、圆按键、划动字符、按下气泡文字）
  - [ ] 数字键盘颜色（collection前景）
  - [ ] 符号键盘颜色（列表字体、collection背景、按键边缘）
  - [ ] panel键盘颜色（按键前景、键盘背景）
- [ ] 暗色主题
  - [ ] 同上所有项
- [ ] 统一命名规范（中文字符串键名 → 英文嵌套结构）

#### 3.2 尺寸配置（dimensions.libsonnet）
从 `lib/fontSize.libsonnet` 和 `lib/center.libsonnet` 迁移：
- [ ] 字体大小
  - [ ] 候选字体（未展开选中、未展开comment、展开选中、展开comment）
  - [ ] preedit区字体
  - [ ] 上划/下划文字（竖屏、横屏）
  - [ ] 长按气泡（文字、sf符号）
  - [ ] 按键前景（文字、英文、sf符号）
  - [ ] toolbar按键（sf符号、文字）
  - [ ] 数字键盘（collection前景、数字前景）
  - [ ] 中文九键（字符、字根、划动）
  - [ ] 符号键盘（左右collection前景）
  - [ ] panel键盘（按键文字、sf符号）
  - [ ] 气泡文字（竖屏滑动、横屏滑动、划动前景）
- [ ] 位置偏移
  - [ ] 26键（上划文字、下划文字、上划sf、下划sf）
  - [ ] 气泡（长按文字、长按sf、划动文字、划动sf、按下文字）
  - [ ] 前景偏移（26键中文、功能键、中文九键字符、中文九键下划、数字键盘数字）
  - [ ] 英文小写偏移
  - [ ] 数字键盘（上划文字、下划文字、上划sf、下划sf）
  - [ ] toolbar（按键、文字、sf符号）
  - [ ] panel键盘（按键文字、sf符号）
  - [ ] 缩放（26键中文、26键英文、toolbar按键、数字键盘）
- [ ] 按钮尺寸
  - [ ] 从 `lib/keyboardLayout.libsonnet` 提取
  - [ ] 竖屏按键尺寸
  - [ ] 横屏按键尺寸

#### 3.3 动画配置（animation.libsonnet）
从 `lib/animation.libsonnet` 迁移：
- [ ] 26键按键动画
- [ ] 其他动画类型

#### 3.4 其他配置（others.libsonnet）
从 `lib/others.libsonnet` 迁移：
- [ ] 高度配置
  - [ ] 竖屏（preedit、toolbar、keyboard、符号键盘、总高度）
  - [ ] 横屏（同上）
- [ ] 方案绑定
  - [ ] 中文键盘方案
  - [ ] 英文键盘方案

### 阶段 4：迁移数据中心

#### 4.1 滑动数据（swipe.libsonnet）
从 `lib/swipeData.libsonnet` 和 `lib/swipeData-en.libsonnet` 迁移：
- [ ] 中文滑动数据
  - [ ] 上滑操作（swipe_up）
    - [ ] q-p 键上滑
    - [ ] a-l 键上滑
    - [ ] z-m 键上滑
    - [ ] 其他键上滑（spaceRight、space、backspace）
  - [ ] 下滑操作（swipe_down）
    - [ ] q-p 键下滑
    - [ ] a-l 键下滑
    - [ ] z-m 键下滑
    - [ ] 其他键下滑
- [ ] 英文滑动数据
  - [ ] 上滑操作（覆盖中文差异部分）
  - [ ] 下滑操作（覆盖中文差异部分）
- [ ] 数字键盘滑动数据
- [ ] 合并重复配置

#### 4.2 长按提示数据（hint.libsonnet）
从 `lib/hintSymbolsData.libsonnet` 迁移：
- [ ] 拼音键盘长按数据
  - [ ] q-p 键长按
  - [ ] a-z 键长按
  - [ ] 特殊键长按（number、enter、symbol）
- [ ] 数字键盘长按数据
  - [ ] number0-number9 键长按
- [ ] 中文九键长按数据
  - [ ] number1 键长按

#### 4.3 集合数据（collection.libsonnet）
从 `lib/collectionData.libsonnet` 迁移：
- [ ] 数字键盘符号
- [ ] 符号键盘分类
  - [ ] 一级分类
  - [ ] 二级分类

#### 4.4 工具栏数据（toolbar.libsonnet）
从 `lib/toolbar.libsonnet` 和 `lib/toolbar-en.libsonnet` 迁移：
- [ ] 中文工具栏
- [ ] 英文工具栏
- [ ] 合并重复配置

### 阶段 5：创建工具库

#### 5.1 样式生成函数（style.libsonnet）
从 `lib/utils.libsonnet` 提取：
- [ ] makeTextStyle() - 创建文本样式
- [ ] makeSystemImageStyle() - 创建 SF Symbols 图标样式
- [ ] makeGeometryStyle() - 创建几何样式
- [ ] makeImageStyle() - 创建图片样式
- [ ] 统一参数命名

#### 5.2 通用工具函数（utils.libsonnet）
从 `lib/utils.libsonnet` 提取：
- [ ] createButton() - 创建按键
- [ ] genPinyinStyles() - 批量生成拼音样式
- [ ] genAlphabeticStyles() - 批量生成字母样式
- [ ] genNumberStyles() - 批量生成数字样式
- [ ] genHintStyles() - 批量生成提示样式

#### 5.3 布局计算函数（layout.libsonnet）
从 `lib/keyboardLayout.libsonnet` 提取：
- [ ] getPortraitLayout() - 竖屏布局
- [ ] getLandscapeLayout() - 横屏布局
- [ ] getButtonSize() - 按键尺寸
- [ ] 布局参数

### 阶段 6：创建键盘文件

#### 6.1 拼音键盘（pinyin_26.jsonnet）
从 `keyboard/pinyin_26.jsonnet` 迁移：
- [ ] 导入配置和数据
- [ ] 定义按键布局
  - [ ] 第一行：q-w-e-r-t-y-u-i-o-p
  - [ ] 第二行：a-s-d-f-g-h-j-k-l
  - [ ] 第三行：shift-z-x-c-v-b-n-m-backspace
  - [ ] 第四行：EnZh-symbol-number-space-spaceRight-enter
- [ ] 定义按键样式
  - [ ] 26个字母键
  - [ ] 功能键（shift、backspace、EnZh、symbol、number、space、spaceRight、enter）
- [ ] 定义滑动操作
- [ ] 定义长按提示
- [ ] 定义动画
- [ ] 定义通知

#### 6.2 字母键盘（alphabetic_26.jsonnet）
从 `keyboard/alphabetic_26.jsonnet` 迁移：
- [ ] 导入配置和数据
- [ ] 复用拼音键盘布局
- [ ] 覆盖英文特定配置
- [ ] 使用英文滑动数据
- [ ] 使用英文工具栏

#### 6.3 数字键盘（numeric_9.jsonnet）
从 `keyboard/numeric_9_portrait.jsonnet` 和 `numeric_9_landscape.jsonnet` 迁移：
- [ ] 导入配置和数据
- [ ] 定义按键布局
  - [ ] 集合视图（左侧符号）
  - [ ] 数字键（1-9）
  - [ ] 其他键（symbol、0、space、equal、period、backspace、enter、return）
- [ ] 支持竖屏和横屏
- [ ] 定义按键样式
- [ ] 定义滑动操作
- [ ] 定义长按提示

#### 6.4 符号键盘（symbolic.jsonnet）
从 `keyboard/symbolic_portrait.jsonnet` 迁移：
- [ ] 导入配置和数据
- [ ] 定义分类符号布局
  - [ ] 一级分类列表
  - [ ] 二级分类列表
- [ ] 定义集合样式

#### 6.5 面板键盘（panel.jsonnet）
从 `keyboard/panel.jsonnet` 迁移：
- [ ] 导入配置和数据
- [ ] 定义浮动模式布局
- [ ] 定义按键样式

### 阶段 7：创建主入口

#### 7.1 主入口文件（main.jsonnet）
- [ ] 导入所有键盘
- [ ] 生成亮色主题配置
  - [ ] pinyin_26_portrait
  - [ ] pinyin_26_landscape
  - [ ] alphabetic_26_portrait
  - [ ] alphabetic_26_landscape
  - [ ] numeric_9_portrait
  - [ ] numeric_9_landscape
  - [ ] symbolic_portrait
  - [ ] panel_portrait
  - [ ] panel_landscape
- [ ] 生成暗色主题配置
  - [ ] 同上所有项
- [ ] 生成 config.yaml

### 阶段 8：测试和验证

#### 8.1 编译测试
- [ ] 编译新架构：`jsonnet -S -m . jsonnet/v2/main.jsonnet`
- [ ] 检查编译错误
- [ ] 修复所有编译错误

#### 8.2 输出对比
- [ ] 编译旧架构：`jsonnet -S -m . jsonnet/main.jsonnet`
- [ ] 对比新旧架构生成的 YAML 文件
  - [ ] light/pinyin_26_portrait.yaml
  - [ ] light/pinyin_26_landscape.yaml
  - [ ] light/alphabetic_26_portrait.yaml
  - [ ] light/alphabetic_26_landscape.yaml
  - [ ] light/numeric_9_portrait.yaml
  - [ ] light/numeric_9_landscape.yaml
  - [ ] light/symbolic_portrait.yaml
  - [ ] light/panel_portrait.yaml
  - [ ] light/panel_landscape.yaml
  - [ ] dark/ 下所有文件
  - [ ] config.yaml
- [ ] 确保输出 100% 一致

#### 8.3 功能测试
- [ ] 在 Hamster 输入法中测试新架构皮肤
- [ ] 测试所有键盘类型
- [ ] 测试所有方向（竖屏、横屏、浮动）
- [ ] 测试所有主题（亮色、暗色）
- [ ] 测试所有交互功能（点击、滑动、长按、动画、通知）

### 阶段 9：文档和清理

#### 9.1 创建文档
- [ ] 创建 README.md（v2 架构说明）
- [ ] 创建 MIGRATION.md（迁移指南）
- [ ] 添加代码注释

#### 9.2 清理旧架构（可选）
- [ ] 标记旧架构为 deprecated
- [ ] 更新 .gitignore
- [ ] 更新构建脚本

---

## 📝 配置项清单

### 主题配置（theme.libsonnet）
```
├── light
│   ├── alphabeticKey
│   │   ├── backgroundNormal
│   │   ├── backgroundHighlight
│   │   └── textNormal
│   ├── functionKey
│   │   ├── backgroundNormal
│   │   ├── backgroundHighlight
│   │   └── textNormal
│   ├── enterKey
│   │   ├── backgroundGreen
│   │   └── textNormal
│   ├── bubble
│   │   ├── background
│   │   ├── border
│   │   └── highlight
│   ├── lowerEdge
│   │   ├── normal
│   │   └── highlight
│   ├── longPress
│   │   ├── textSelected
│   │   ├── textUnselected
│   │   ├── backgroundSelected
│   │   ├── backgroundShadow
│   │   └── background
│   ├── candidate
│   │   ├── textSelected
│   │   ├── textUnselected
│   │   └── backgroundSelected
│   ├── toolbar
│   │   ├── buttonColor
│   │   ├── roundButtonColor
│   │   ├── swipeCharColor
│   │   └── pressedBubbleTextColor
│   ├── numeric
│   │   └── collectionTextColor
│   ├── symbolic
│   │   ├── listTextSelected
│   │   ├── listTextUnselected
│   │   ├── leftCollectionBackground
│   │   ├── leftCollectionLowerEdge
│   │   ├── rightCollectionBackground
│   │   ├── rightCollectionLowerEdge
│   │   └── keyBorder
│   ├── panel
│   │   ├── textColor
│   │   └── keyboardBackground
│   └── textNormal
└── dark
    └── (同 light 结构)
```

### 尺寸配置（dimensions.libsonnet）
```
├── fontSize
│   ├── candidate
│   │   ├── collapsedSelected
│   │   ├── collapsedComment
│   │   ├── expandedSelected
│   │   └── expandedComment
│   ├── preedit
│   ├── swipe
│   │   ├── portrait
│   │   │   ├── up
│   │   │   └── down
│   │   └── landscape
│   │       ├── up
│   │       └── down
│   ├── hintBubble
│   │   ├── text
│   │   └── sfSymbol
│   ├── button
│   │   ├── text
│   │   ├── english
│   │   └── sfSymbol
│   ├── toolbar
│   │   ├── sfSymbol
│   │   └── text
│   ├── numeric
│   │   ├── collection
│   │   └── number
│   ├── cn9
│   │   ├── character
│   │   ├── root
│   │   └── swipe
│   ├── symbolic
│   │   ├── leftCollection
│   │   └── rightCollection
│   ├── panel
│   │   ├── text
│   │   └── sfSymbol
│   └── bubble
│       ├── portraitSwipe
│       ├── landscapeSwipe
│       └── swipeForeground
├── offset
│   ├── swipe
│   │   ├── portrait
│   │   │   ├── upText
│   │   │   ├── downText
│   │   │   ├── upSymbol
│   │   │   └── downSymbol
│   │   └── landscape
│   │       └── (同 portrait)
│   ├── bubble
│   │   ├── longPressText
│   │   ├── longPressSymbol
│   │   ├── swipeText
│   │   ├── swipeSymbol
│   │   └── pressedText
│   ├── foreground
│   │   ├── pinyin26
│   │   ├── functionKey
│   │   ├── cn9Character
│   │   ├── cn9Down
│   │   ├── numericNumber
│   │   └── alphabetic26
│   ├── numericSwipe
│   │   ├── upText
│   │   ├── downText
│   │   ├── upSymbol
│   │   └── downSymbol
│   ├── toolbar
│   │   ├── button
│   │   ├── text
│   │   └── symbol
│   ├── panel
│   │   ├── text
│   │   └── symbol
│   └── scale
│       ├── pinyin26
│       ├── alphabetic26
│       ├── toolbar
│       └── numeric
└── buttonSize
    ├── portrait
    │   ├── normal
    │   ├── special
    │   ├── shift
    │   ├── backspace
    │   ├── symbol
    │   ├── enZh
    │   ├── number
    │   ├── space
    │   ├── spaceRight
    │   └── enter
    └── landscape
        └── (同 portrait)
```

### 数据配置（data/）
```
├── swipe
│   ├── chinese
│   │   ├── up
│   │   │   ├── q-p
│   │   │   ├── a-l
│   │   │   ├── z-m
│   │   │   └── other
│   │   └── down
│   │       ├── (同 up)
│   └── english
│       ├── up
│       │   └── (覆盖差异)
│       └── down
│           └── (覆盖差异)
├── hint
│   ├── pinyin
│   │   ├── q-p
│   │   ├── a-z
│   │   └── special
│   ├── numeric
│   │   └── number0-9
│   └── cn9
│       └── number1
├── collection
│   ├── numericSymbols
│   └── symbolicCategories
└── toolbar
    ├── chinese
    └── english
```

---

## 🔄 变量命名规范

### 配置命名
- 使用 camelCase
- 使用英文描述性名称
- 避免缩写，除非是通用缩写

**示例**：
```jsonnet
// ✅ 好的命名
alphabeticKey.backgroundNormal
fontSize.candidate.collapsedSelected
offset.swipe.portrait.upText

// ❌ 不好的命名
'字母键背景颜色-普通'
candidateFontSize1
offset_up_swipe
```

### 键盘文件命名
- 格式：`{type}_{layout}.jsonnet`
- type: pinyin, alphabetic, numeric, symbolic, panel
- layout: 26, 9, portrait, landscape

**示例**：
- `pinyin_26.jsonnet`
- `numeric_9.jsonnet` (同时支持 portrait/landscape)

### 函数命名
- 动词开头，使用 camelCase
- 清晰描述函数功能

**示例**：
```jsonnet
makeTextStyle(params)
createButton(params)
genPinyinStyles(theme)
```

---

## ✅ 验收标准

### 功能完整性
- [ ] 所有键盘类型正常工作
- [ ] 所有方向（竖屏、横屏、浮动）正常显示
- [ ] 所有主题（亮色、暗色）正常切换
- [ ] 所有交互功能（点击、滑动、长按、动画、通知）正常

### 输出一致性
- [ ] 新旧架构生成的 YAML 文件完全一致
- [ ] 使用 diff 工具验证无差异

### 代码质量
- [ ] 所有文件都有清晰的注释
- [ ] 命名规范统一
- [ ] 无重复代码
- [ ] 无未使用的配置

### 性能要求
- [ ] 编译时间不超过旧架构的 120%
- [ ] 生成的 YAML 文件大小与旧架构相近

---

## 📚 参考资料

### 官方文档
- [皮肤结构](https://ihsiao.com/apps/hamster/v3/docs/guides/skins/structure/)
- [布局](https://ihsiao.com/apps/hamster/v3/docs/guides/skins/layout/)
- [样式](https://ihsiao.com/apps/hamster/v3/docs/guides/skins/styles/)
- [动作](https://ihsiao.com/apps/hamster/v3/docs/guides/skins/action/)
- [动画](https://ihsiao.com/apps/hamster/v3/docs/guides/skins/animation/)
- [通知](https://ihsiao.com/apps/hamster/v3/docs/guides/skins/notifications/)
- [集合](https://ihsiao.com/apps/hamster/v3/docs/guides/skins/collection/)
- [预编辑区](https://ihsiao.com/apps/hamster/v3/docs/guides/skins/preedit/)

### SF Symbols
- SF Symbols App（Mac App Store 下载）
- [SF Symbols 官方文档](https://developer.apple.com/sf-symbols/)

### Jsonnet
- [Jsonnet 官方文档](https://jsonnet.org/learning/tutorial.html)

---

## 📞 注意事项

1. **不要修改旧架构**：所有工作在 `jsonnet/v2/` 目录进行
2. **保持输出一致**：新旧架构生成的 YAML 必须完全相同
3. **逐步迁移**：每个阶段完成后进行测试，不要一次性迁移所有内容
4. **详细注释**：所有配置都要添加注释，说明用途
5. **命名规范**：严格遵循命名规范，保持一致性
6. **版本控制**：每个阶段完成后提交代码，便于回滚

---

**创建时间**：2026-02-13
**最后更新**：2026-02-13
**状态**：准备阶段