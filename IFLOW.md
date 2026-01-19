# iPure·Pro 项目上下文

## 项目概述

iPure·Pro 是一款基于 Hamster 输入法的皮肤配置项目，使用 Jsonnet 模板语言生成键盘布局配置。项目支持亮色和暗色两种主题，专为 iOS 设备（iPhone 和 iPad）设计，具有现代化的 UI 设计和丰富的交互功能。

**核心特点：**
- 使用 SF Symbols 图标系统
- 支持中英文输入切换
- 提供滑动和长按快捷功能
- 适配 iPhone 和 iPad 的多种屏幕方向
- 智能回车键（根据输入框类型自动变化）
- 模块化架构，易于维护和扩展

## 技术栈

- **配置语言：** Jsonnet
- **输出格式：** YAML
- **图标系统：** SF Symbols (iOS 15+)
- **目标平台：** Hamster 输入法 v3+

## 项目结构

```
iPurePro/
├── config.yaml              # 皮肤配置元数据（生成后）
├── build_skin.sh            # 构建脚本，自动生成皮肤包
├── jsonnet/                 # Jsonnet 源文件（配置文件，需要版本管理）
│   ├── main.jsonnet        # 主入口文件，定义所有键盘配置
│   ├── keyboard/           # 键盘布局定义（具体键盘配置文件）
│   │   ├── pinyin_26.jsonnet          # 拼音键盘（26键）
│   │   ├── alphabetic_26.jsonnet      # 字母键盘（26键）
│   │   ├── numeric_9_portrait.jsonnet # 数字键盘（竖屏）
│   │   ├── numeric_9_landscape.jsonnet# 数字键盘（横屏）
│   │   ├── symbolic_portrait.jsonnet  # 符号键盘
│   │   ├── emoji_portrait.jsonnet     # Emoji键盘（已注释）
│   │   └── panel.jsonnet              # 面板键盘
│   └── lib/               # 共享库文件（可修改的配置文件）
│       ├── core/          # 核心库（常量、主题、工具函数）
│       │   ├── constants.libsonnet        # 常量定义
│       │   ├── theme.libsonnet            # 主题定义
│       │   ├── utils.libsonnet            # 工具函数
│       │   ├── layout.libsonnet           # 布局定义
│       │   └── buttonSize.libsonnet       # 按键尺寸定义
│       ├── components/   # 组件库（按键组件）
│       │   └── button.libsonnet           # 按键创建函数
│       ├── styles/        # 样式库（样式生成）
│       │   └── generator.libsonnet        # 样式生成函数
│       ├── data/          # 数据库（滑动、提示、集合数据）
│       │   ├── swipeData.libsonnet        # 滑动手势数据
│       │   ├── hintSymbolsData.libsonnet  # 提示符号数据
│       │   └── collectionData.libsonnet   # 集合数据
│       ├── animation.libsonnet            # 动画配置
│       ├── center.libsonnet               # 中心偏移配置
│       ├── color.libsonnet                # 颜色配置（亮色/暗色主题）
│       ├── fontSize.libsonnet             # 字体大小配置
│       ├── hintSymbolsStyles.libsonnet    # 长按提示符号样式
│       ├── keyboardLayout.libsonnet       # 键盘布局参数
│       ├── others.libsonnet               # 其他配置（高度、方案等）
│       ├── swipeData.libsonnet            # 滑动操作数据（中文）
│       ├── swipeData-en.libsonnet         # 滑动操作数据（英文）
│       ├── swipeStyles.libsonnet          # 滑动样式
│       ├── toolbar.libsonnet              # 工具栏配置（中文）
│       ├── toolbar-en.libsonnet           # 工具栏配置（英文）
│       └── utils.libsonnet                # 工具函数（兼容性）
├── light/                    # 亮色主题生成的 YAML 文件（自动生成，不追踪）
│   ├── alphabetic_26_portrait.yaml
│   ├── alphabetic_26_landscape.yaml
│   ├── numeric_9_portrait.yaml
│   ├── numeric_9_landscape.yaml
│   ├── pinyin_26_portrait.yaml
│   ├── pinyin_26_landscape.yaml
│   ├── symbolic_portrait.yaml
│   ├── panel_portrait.yaml
│   ├── panel_landscape.yaml
│   └── resources/           # 亮色主题资源文件
└── dark/                     # 暗色主题生成的 YAML 文件（自动生成，不追踪）
    ├── alphabetic_26_portrait.yaml
    ├── alphabetic_26_landscape.yaml
    ├── numeric_9_portrait.yaml
    ├── numeric_9_landscape.yaml
    ├── pinyin_26_portrait.yaml
    ├── pinyin_26_landscape.yaml
    ├── symbolic_portrait.yaml
    ├── panel_portrait.yaml
    ├── panel_landscape.yaml
    └── resources/           # 暗色主题资源文件
```

## Jsonnet 目录说明

`jsonnet/` 目录包含所有源配置文件，是项目的核心部分，需要进行 Git 版本管理。

### keyboard/ 目录
包含各个键盘的具体配置文件，每个文件定义一个键盘类型：
- **pinyin_26.jsonnet**：中文拼音键盘，26 键布局
- **alphabetic_26.jsonnet**：英文字母键盘，26 键布局
- **numeric_9_portrait.jsonnet**：数字键盘竖屏版本，9 键布局
- **numeric_9_landscape.jsonnet**：数字键盘横屏版本，9 键布局
- **symbolic_portrait.jsonnet**：符号键盘
- **panel.jsonnet**：面板键盘（浮动模式）

### lib/ 目录
包含共享的库文件，提供可复用的配置和工具函数。

#### 新增模块化架构（2026年重构）

项目已进行全面重构，采用模块化架构，提高代码的可维护性和扩展性：

**1. 核心库 (core/)**
- **constants.libsonnet**：集中管理所有常量
  - 按钮尺寸常量（insets、corner radius、scale）
  - 字体大小常量（候选、按键、滑动、工具栏等）
  - 位置偏移常量（按键文本、滑动、工具栏等）
  - 布局常量（列比例、横屏按键宽度等）
  - 动画常量

- **theme.libsonnet**：主题定义
  - 亮色主题（light）
  - 暗色主题（dark）
  - 每个主题包含字母键、功能键、回车键等配置
  - 修复了颜色命名错误（'enter键背景(蓝色)' → 'enter键背景(绿色)'）

- **utils.libsonnet**：工具函数
  - makeTextStyle()：创建文本样式
  - makeSymbolStyle()：创建符号样式
  - makeGeometryStyle()：创建几何样式
  - generate26KeyStyles()：批量生成26键样式

- **layout.libsonnet**：布局定义
  - 竖屏布局
  - 横屏布局
  - 键盘布局参数

- **buttonSize.libsonnet**：按键尺寸定义
  - 竖屏按键尺寸
  - 横屏按键尺寸

**2. 组件库 (components/)**
- **button.libsonnet**：按键创建函数
  - createLetterButton()：创建字母按键
  - createEnterButton()：创建回车按键
  - createShiftButton()：创建Shift按键
  - 等等

**3. 样式库 (styles/)**
- **generator.libsonnet**：样式生成函数
  - generateBaseStyles()：生成基础样式
  - generateEnterButtonStyles()：生成回车按键样式
  - generateFunctionKeyStyles()：生成功能键样式

**4. 数据库 (data/)**
- **swipeData.libsonnet**：滑动手势数据
  - swipeUp：上滑操作定义
  - swipeDown：下滑操作定义

- **hintSymbolsData.libsonnet**：提示符号数据
  - 长按提示符号定义

- **collectionData.libsonnet**：集合数据
  - 符号集合数据
  - 数字集合数据

**5. 兼容性库（保留原有文件）**
为了保持向后兼容性，原有的lib文件仍然保留：
- **animation.libsonnet**：动画配置
- **center.libsonnet**：中心偏移配置
- **color.libsonnet**：颜色配置（已修复颜色命名错误）
- **fontSize.libsonnet**：字体大小配置
- **hintSymbolsStyles.libsonnet**：长按提示符号样式
- **keyboardLayout.libsonnet**：键盘布局参数
- **others.libsonnet**：其他配置（高度、方案等）
- **swipeData.libsonnet**：滑动操作数据（中文）
- **swipeData-en.libsonnet**：滑动操作数据（英文）
- **swipeStyles.libsonnet**：滑动样式
- **toolbar.libsonnet**：工具栏配置（中文）
- **toolbar-en.libsonnet**：工具栏配置（英文）
- **utils.libsonnet**：工具函数（兼容性）

**重要说明：**
- `jsonnet/` 目录下的所有文件都是**配置文件**，可以修改
- 只有 `light/` 和 `dark/` 目录下的 `.yaml` 文件是自动生成的，不需要版本管理
- 修改任何 Jsonnet 文件后，需要运行构建命令重新生成 YAML 文件
- 新的模块化架构使得代码更易于维护和扩展

## 构建和运行

### 构建命令

在项目根目录执行以下命令生成所有键盘配置文件：

```bash
jsonnet -S -m . jsonnet/main.jsonnet
```

**命令说明：**
- `-S`：输出格式化为字符串
- `-m .`：将输出文件写入当前目录
- `jsonnet/main.jsonnet`：主入口文件

该命令会：
1. 读取 `jsonnet/main.jsonnet` 作为入口
2. 生成所有键盘配置文件（拼音、字母、数字、符号、面板）
3. 输出到对应的 `light/` 和 `dark/` 目录
4. 生成 `config.yaml` 配置文件

### 构建皮肤包

使用项目提供的构建脚本自动生成皮肤包：

```bash
bash build_skin.sh
```

**脚本功能：**
1. 清理之前的构建文件
2. 创建构建目录
3. 复制必要的文件（config.yaml、light/、dark/、resources/、demo.png）
4. 打包成 zip 文件
5. 重命名为 .cskin 文件
6. 复制到目标位置（iCloud Drive）
7. 清理临时文件

**输出位置：**
`/Users/athena/Library/Mobile Documents/com~apple~CloudDocs/SKINS/iPure·Pro.cskin`

### 安装方法

1. 执行构建命令生成配置文件
2. 将生成的 `.cskin` 文件放入 Hamster 输入法的皮肤目录
3. 在输入法设置中选择 iPure·Pro 皮肤

## 开发约定

### 键盘类型

项目支持以下键盘类型，每个类型都有竖屏（portrait）和横屏（landscape）版本：

- **拼音键盘 (pinyin_26)**：中文拼音输入，26 键布局
- **字母键盘 (alphabetic_26)**：英文输入，26 键布局
- **数字键盘 (numeric_9)**：数字输入，9 键布局
- **符号键盘 (symbolic)**：符号输入
- **面板键盘 (panel)**：浮动模式键盘

### 主题配置

主题配置在 `jsonnet/lib/color.libsonnet` 和 `jsonnet/lib/core/theme.libsonnet` 中定义，包含：

**亮色主题 (light)：**
- 字母键背景：白色 (#FFFFFF)
- 功能键背景：半透明灰色
- 主色调：#23C891（绿色）
- 按键前景：黑色

**暗色主题 (dark)：**
- 字母键背景：半透明灰色 (#D1D1D165)
- 功能键背景：半透明深灰色
- 主色调：#23C891（绿色）
- 按键前景：白色

**注意：** 已修复颜色命名错误，回车键背景现在正确命名为 'enter键背景(绿色)'。

### 功能特性

#### 1. 滑动功能

按键支持上下滑动操作：

- **上滑**：数字、符号、快捷操作（全选、剪切、复制、粘贴等）
- **下滑**：特殊符号、快捷操作（撤销、重做等）

滑动数据定义在：
- `jsonnet/lib/data/swipeData.libsonnet`（中文）
- `jsonnet/lib/swipeData-en.libsonnet`（英文）

#### 2. 长按功能

长按按键显示候选字符或快捷操作，数据定义在 `jsonnet/lib/data/hintSymbolsData.libsonnet`。

#### 3. 智能回车

根据输入框类型自动显示不同的回车文字：
- Return (0, 2, 3, 5, 8, 10, 11)
- Go/前进 (1, 4)
- Search (6)
- Send (7)
- Done (9)

#### 4. Shift 键

按下 Shift 时显示绿色背景，指示当前输入状态。

### 字体大小配置

字体大小定义在 `jsonnet/lib/fontSize.libsonnet` 和 `jsonnet/lib/core/constants.libsonnet`：
- 中文按键：18pt
- 英文按键：19pt
- 滑动符号：12pt
- 工具栏图标：18pt

### 按键位置配置

按键位置和尺寸定义在 `jsonnet/lib/center.libsonnet` 和 `jsonnet/lib/core/layout.libsonnet`：
- 字母按键垂直偏移：0.55
- 功能键偏移：0.45

### 工具栏配置

工具栏配置在 `jsonnet/lib/toolbar.libsonnet`（中文）和 `jsonnet/lib/toolbar-en.libsonnet`（英文）中定义，包含以下功能图标：
- 空格
- 数字切换
- Shift
- 回车
- 搜索
- 发送
- 前往
- 完成
- 符号切换
- 全选
- 剪切
- 复制
- 粘贴
- 剪贴板列表
- 重输
- 换行
- Emoji
- 脚本运行
- 收藏短语

## 设备适配

### iPhone
- 竖屏模式 (portrait)
- 横屏模式 (landscape)

### iPad
- 竖屏模式 (portrait)
- 横屏模式 (landscape)
- 浮动模式 (floating)

## 配置参数说明

### 主要配置文件

1. **config.yaml**：皮肤元数据，定义作者、名称和各键盘类型在不同设备和方向下的配置文件映射

2. **jsonnet/main.jsonnet**：主入口文件，负责：
   - 导入所有键盘类型定义
   - 为每个键盘类型生成亮色和暗色主题
   - 输出所有 YAML 配置文件

3. **jsonnet/lib/color.libsonnet**：颜色配置，定义所有主题颜色

4. **jsonnet/lib/core/theme.libsonnet**：主题定义（新架构）

5. **jsonnet/lib/keyboardLayout.libsonnet**：键盘布局参数，包括按键尺寸、位置等

6. **jsonnet/lib/core/constants.libsonnet**：常量定义（新架构）

### 关键函数

在 `jsonnet/lib/utils.libsonnet` 和 `jsonnet/lib/core/utils.libsonnet` 中定义了多个工具函数：

- `makeSystemImageStyle()`：创建 SF Symbols 图标样式
- `makeImageStyle()`：创建自定义图片样式
- `makeTextStyle()`：创建文本样式
- `makeGeometryStyle()`：创建几何图形样式
- `genPinyinStyles()`：批量生成拼音按键前景样式
- `genAlphabeticStyles()`：批量生成字母按键前景样式
- `genNumberStyles()`：批量生成数字按键前景样式
- `genHintStyles()`：批量生成提示样式

## 修改指南

### ⚠️ 重要原则：保证统一性

**所有修改必须保证对所有键盘类型、亮色和暗色主题都统一应用，确保键盘的一致性。**

修改任何功能时，需要考虑：
1. **键盘类型**：拼音键盘、字母键盘、数字键盘、符号键盘、面板键盘
2. **屏幕方向**：竖屏、横屏
3. **主题模式**：亮色、暗色
4. **设备类型**：iPhone、iPad

### 使用新的模块化架构

项目已重构为模块化架构，推荐使用新的核心库进行修改：

#### 修改常量

编辑 `jsonnet/lib/core/constants.libsonnet`：
```jsonnet
{
  BUTTON: {
    INSETS: { top: 3.5, left: 2.5, bottom: 3.5, right: 2.5 },
    CORNER_RADIUS: 7,
    SCALE: 0.87,
  },
  FONT_SIZE: {
    BUTTON: {
      TEXT: 18,
      ENGLISH: 19,
      SYMBOL: 14,
    },
  },
  // ...
}
```

#### 修改主题

编辑 `jsonnet/lib/core/theme.libsonnet`：
```jsonnet
{
  light: {
    alphabeticKey: {
      backgroundNormal: '#FFFFFF',
      backgroundHighlight: '#ABB0BA',
      textNormal: '#000000',
    },
    enterKey: {
      backgroundGreen: '#23C891',
      textNormal: '#000000',
    },
  },
  dark: {
    // 暗色主题配置
  }
}
```

#### 修改颜色（兼容性）

如果需要修改 `jsonnet/lib/color.libsonnet`（向后兼容）：
```jsonnet
{
  light: {
    '字母键背景颜色-普通': '#FFFFFF',
    '字母键背景颜色-高亮': '#ABB0BA',
    '按键前景颜色': '#000000',
    // ...
  },
  dark: {
    // 暗色主题配置
  }
}
```

### 修改示例

#### 示例 1：修改符号按键的显示（从图标改为文字）

**需求**：将所有键盘的符号按键从 SF Symbols 图标改为中文「符」字

**需要修改的文件**：
- `jsonnet/keyboard/pinyin_26.jsonnet` - 拼音键盘
- `jsonnet/keyboard/alphabetic_26.jsonnet` - 字母键盘
- `jsonnet/keyboard/numeric_9_portrait.jsonnet` - 数字键盘竖屏

**注意**：`numeric_9_landscape.jsonnet` 会自动继承 `numeric_9_portrait.jsonnet` 的定义，不需要单独修改。

**修改方法**：
```jsonnet
// 修改前
symbolButtonForegroundStyle: utils.makeSystemImageStyle(
  params={
    systemImageName: 'xmark.triangle.circle.square',
    normalColor: color[theme]['按键前景颜色'],
    highlightColor: color[theme]['按键前景颜色'],
    fontSize: fontSize['按键前景文字大小'],
    center: center['功能键前景文字偏移'],
  }
),

// 修改后
symbolButtonForegroundStyle: utils.makeTextStyle(
  params={
    text: '符',
    normalColor: color[theme]['按键前景颜色'],
    highlightColor: color[theme]['按键前景颜色'],
    fontSize: fontSize['按键前景文字大小'],
    center: { x: 0.5, y: 0.48 },  // 向上调整0.02
  }
),
```

#### 示例 2：修改逗号/句号按键的行为和显示

**需求**：
- 点击输入句号（。），上划输入逗号（，）
- 两个标点垂直居中显示

**需要修改的文件**：
- `jsonnet/keyboard/pinyin_26.jsonnet` - 中文拼音键盘
- `jsonnet/keyboard/alphabetic_26.jsonnet` - 英文字母键盘
- `jsonnet/lib/data/swipeData.libsonnet` - 中文滑动数据
- `jsonnet/lib/swipeData-en.libsonnet` - 英文滑动数据（兼容性）

**修改方法**：

1. **修改滑动数据**（data/swipeData.libsonnet）：
```jsonnet
// 修改 spaceRight 的上划操作
spaceRight: { action: { character: '，' }, label: { text: '' } },
```

2. **修改按键配置**（pinyin_26.jsonnet）：
```jsonnet
// 修改默认点击操作
spaceRightButton: createButton(
  params={
    key: 'spaceRight',
    size: ButtonSize['spaceRight键size'],
    action: { character: '。' },  // 改为句号
    // ...
  }
),

// 修改显示位置，垂直居中
spaceRightButtonForegroundStyle: utils.makeTextStyle(
  params={
    text: '，',
    normalColor: color[theme]['按键前景颜色'],
    highlightColor: color[theme]['按键前景颜色'],
    fontSize: fontSize['按键前景文字大小'],
    center: { x: 0.58, y: 0.25 },  // 向右调整0.08，向上调整0.1
  }
),

spaceRightButtonForegroundStyle2: utils.makeTextStyle(
  params={
    text: '。',
    normalColor: color[theme]['按键前景颜色'],
    highlightColor: color[theme]['按键前景颜色'],
    fontSize: fontSize['按键前景文字大小'],
    center: { x: 0.58, y: 0.55 },  // 向右调整0.08，向上调整0.1
  }
),
```

#### 示例 3：修改全局字体大小

**需求**：调整上划和下滑文字的大小

**需要修改的文件**：
- `jsonnet/lib/fontSize.libsonnet` - 字体大小配置
- 或 `jsonnet/lib/core/constants.libsonnet` - 常量定义（新架构）

**修改方法**：
```jsonnet
// 在 fontSize.libsonnet 中
{
  '上划文字大小': 12,  // 修改这个值
  '下划文字大小': 12,  // 修改这个值
  // ...
}

// 或在 constants.libsonnet 中
{
  FONT_SIZE: {
    SWIPE: {
      PORTRAIT: 12,  // 修改这个值
      LANDSCAPE: 9,
    },
  },
}
```

**影响范围**：此修改会自动应用到所有键盘类型、所有主题模式。

#### 示例 4：修改英文键盘的逗号和句号位置

**需求**：调整英文键盘中逗号和句号的显示位置

**需要修改的文件**：
- `jsonnet/keyboard/alphabetic_26.jsonnet` - 英文字母键盘

**修改方法**：
```jsonnet
// 修改前
spaceRightButtonForegroundStyle: utils.makeTextStyle(
  params={
    text: ',',
    normalColor: color[theme]['按键前景颜色'],
    highlightColor: color[theme]['按键前景颜色'],
    fontSize: fontSize['按键前景文字大小'],
    center: { x: 0.58, y: 0.25 },  // 向右调整0.08，向上调整0.1
  }
),

spaceRightButtonForegroundStyle2: utils.makeTextStyle(
  params={
    text: '.',
    normalColor: color[theme]['按键前景颜色'],
    highlightColor: color[theme]['按键前景颜色'],
    fontSize: fontSize['按键前景文字大小'],
    center: { x: 0.58, y: 0.55 },  // 向右调整0.08，向上调整0.1
  }
),

// 修改后
spaceRightButtonForegroundStyle: utils.makeTextStyle(
  params={
    text: ',',
    normalColor: color[theme]['按键前景颜色'],
    highlightColor: color[theme]['按键前景颜色'],
    fontSize: fontSize['按键前景文字大小'],
    center: { x: 0.56, y: 0.26 },  // 往左移动0.02，往下移动0.01
  }
),

spaceRightButtonForegroundStyle2: utils.makeTextStyle(
  params={
    text: '.',
    normalColor: color[theme]['按键前景颜色'],
    highlightColor: color[theme]['按键前景颜色'],
    fontSize: fontSize['按键前景文字大小'],
    center: { x: 0.56, y: 0.56 },  // 往左移动0.02，往下移动0.01
  }
),
```

#### 示例 5：修改颜色主题

**需求**：调整亮色主题的按键背景颜色

**需要修改的文件**：
- `jsonnet/lib/color.libsonnet` - 颜色配置（兼容性）
- 或 `jsonnet/lib/core/theme.libsonnet` - 主题定义（新架构）

**修改方法**：
```jsonnet
// 在 color.libsonnet 中
{
  light: {
    '字母键背景颜色-普通': '#FFFFFF',  // 修改这个值
    '字母键背景颜色-高亮': '#ABB0BA',
    // ...
  },
  dark: {
    // 暗色主题配置
  }
}

// 或在 theme.libsonnet 中
{
  light: {
    alphabeticKey: {
      backgroundNormal: '#FFFFFF',  // 修改这个值
      backgroundHighlight: '#ABB0BA',
      textNormal: '#000000',
    },
  },
  dark: {
    // 暗色主题配置
  }
}
```

### 修改滑动操作

编辑 `jsonnet/lib/data/swipeData.libsonnet`（中文）或 `jsonnet/lib/swipeData-en.libsonnet`（英文）。

### 修改字体大小

编辑 `jsonnet/lib/fontSize.libsonnet` 或 `jsonnet/lib/core/constants.libsonnet`。

### 修改工具栏

编辑 `jsonnet/lib/toolbar.libsonnet`（中文）或 `jsonnet/lib/toolbar-en.libsonnet`（英文）。

### 添加新的键盘类型

1. 在 `jsonnet/keyboard/` 目录下创建新的 `.jsonnet` 文件
2. 在 `jsonnet/main.jsonnet` 中导入并生成配置
3. 在 `config.yaml` 中添加映射关系

## 重构说明（2026年）

### 重构目标

项目已进行全面重构，主要目标是：
1. **减少引用** - 通过核心库统一管理常量和工具函数
2. **优化结构** - 清晰的模块分离（core/components/data/styles）
3. **易于修改** - 集中化的常量和配置管理
4. **变量命名准确** - 修复了颜色命名错误
5. **保持功能不变** - 所有现有功能完整保留

### 重构内容

1. **新增核心库模块** (`jsonnet/lib/core/`)
   - constants.libsonnet - 常量定义
   - theme.libsonnet - 主题定义
   - utils.libsonnet - 工具函数
   - layout.libsonnet - 布局定义
   - buttonSize.libsonnet - 按键尺寸定义

2. **新增组件模块** (`jsonnet/lib/components/`)
   - button.libsonnet - 按键创建函数

3. **新增样式模块** (`jsonnet/lib/styles/`)
   - generator.libsonnet - 样式生成函数

4. **新增数据模块** (`jsonnet/lib/data/`)
   - swipeData.libsonnet - 滑动手势数据
   - hintSymbolsData.libsonnet - 提示符号数据
   - collectionData.libsonnet - 集合数据

5. **修复颜色命名错误**
   - 'enter键背景(蓝色)' → 'enter键背景(绿色)'
   - 颜色 #23C891 是绿色，不是蓝色

6. **更新现有库文件**
   - 所有原始lib文件已恢复并保持兼容性
   - 键盘文件已更新以使用新的库结构

### 向后兼容性

为了保持向后兼容性，原有的lib文件仍然保留在 `jsonnet/lib/` 目录中。新的模块化架构与原有架构并存，开发者可以选择使用新的核心库或继续使用原有的库文件。

## 注意事项

1. 修改 Jsonnet 文件后，必须重新执行构建命令生成 YAML 文件
2. 亮色和暗色主题的颜色配置需要同步修改
3. 中文和英文的滑动操作数据是分开的，需要分别修改
4. 按键尺寸和位置需要考虑不同设备的适配
5. 使用 SF Symbols 图标时，确保图标名称正确（参考 Apple 官方文档）
6. 新的模块化架构提供了更好的代码组织，推荐使用新的核心库进行开发
7. 修改常量时，优先考虑使用 `jsonnet/lib/core/constants.libsonnet`

## 作者信息

**iPure·Pro** by Astral

---

*基于 Hamster 输入法，使用 Jsonnet 配置生成*