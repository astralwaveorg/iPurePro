# iPure·Pro 项目上下文

## 项目概述

iPure·Pro 是一款基于 Hamster 输入法的皮肤配置项目，使用 Jsonnet 模板语言生成键盘布局配置。项目支持亮色和暗色两种主题，专为 iOS 设备（iPhone 和 iPad）设计，具有现代化的 UI 设计和丰富的交互功能。

**核心特点：**
- 使用 SF Symbols 图标系统
- 支持中英文输入切换
- 提供滑动和长按快捷功能
- 适配 iPhone 和 iPad 的多种屏幕方向
- 智能回车键（根据输入框类型自动变化）

## 技术栈

- **配置语言：** Jsonnet
- **输出格式：** YAML
- **图标系统：** SF Symbols (iOS 15+)
- **目标平台：** Hamster 输入法 v3+

## 项目结构

```
iPurePro/
├── config.yaml              # 皮肤配置元数据（生成后）
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
│       ├── animation.libsonnet        # 动画配置
│       ├── center.libsonnet           # 中心偏移配置
│       ├── collectionData.libsonnet   # 集合数据
│       ├── color.libsonnet            # 颜色配置（亮色/暗色主题）
│       ├── fontSize.libsonnet         # 字体大小配置
│       ├── hintSymbolsData.libsonnet  # 长按提示符号数据
│       ├── hintSymbolsStyles.libsonnet# 长按提示符号样式
│       ├── keyboardLayout.libsonnet   # 键盘布局参数
│       ├── others.libsonnet           # 其他配置（高度、方案等）
│       ├── swipeData.libsonnet        # 滑动操作数据（中文）
│       ├── swipeData-en.libsonnet     # 滑动操作数据（英文）
│       ├── swipeStyles.libsonnet      # 滑动样式
│       ├── toolbar.libsonnet          # 工具栏配置（中文）
│       ├── toolbar-en.libsonnet       # 工具栏配置（英文）
│       └── utils.libsonnet            # 工具函数
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
包含共享的库文件，提供可复用的配置和工具函数：
- **配置类文件**：定义颜色、字体大小、布局参数等基础配置
- **数据类文件**：定义滑动操作数据、长按提示数据、工具栏数据等
- **工具类文件**：提供样式生成、工具函数等

**重要说明：**
- `jsonnet/` 目录下的所有文件都是**配置文件**，可以修改
- 只有 `light/` 和 `dark/` 目录下的 `.yaml` 文件是自动生成的，不需要版本管理
- 修改任何 Jsonnet 文件后，需要运行构建命令重新生成 YAML 文件

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

### 安装方法

1. 执行构建命令生成配置文件
2. 将生成的文件放入 Hamster 输入法的皮肤目录
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

主题配置在 `jsonnet/lib/color.libsonnet` 中定义，包含：

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

### 功能特性

#### 1. 滑动功能

按键支持上下滑动操作：

- **上滑**：数字、符号、快捷操作（全选、剪切、复制、粘贴等）
- **下滑**：特殊符号、快捷操作（撤销、重做等）

滑动数据定义在：
- `jsonnet/lib/swipeData.libsonnet`（中文）
- `jsonnet/lib/swipeData-en.libsonnet`（英文）

#### 2. 长按功能

长按按键显示候选字符或快捷操作，数据定义在 `jsonnet/lib/hintSymbolsData.libsonnet`。

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

字体大小定义在 `jsonnet/lib/fontSize.libsonnet`：
- 中文按键：18pt
- 英文按键：19pt
- 滑动符号：12pt
- 工具栏图标：18pt

### 按键位置配置

按键位置和尺寸定义在 `jsonnet/lib/keyboardLayout.libsonnet`：
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

4. **jsonnet/lib/keyboardLayout.libsonnet**：键盘布局参数，包括按键尺寸、位置等

### 关键函数

在 `jsonnet/lib/utils.libsonnet` 中定义了多个工具函数：

- `makeSystemImageStyle()`：创建 SF Symbols 图标样式
- `makeImageStyle()`：创建自定义图片样式
- `makeTextStyle()`：创建文本样式
- `makeGeometryStyle()`：创建几何图形样式
- `genPinyinStyles()`：批量生成拼音按键前景样式
- `genHintStyles()`：批量生成提示样式

## 修改指南

### ⚠️ 重要原则：保证统一性

**所有修改必须保证对所有键盘类型、亮色和暗色主题都统一应用，确保键盘的一致性。**

修改任何功能时，需要考虑：
1. **键盘类型**：拼音键盘、字母键盘、数字键盘、符号键盘、面板键盘
2. **屏幕方向**：竖屏、横屏
3. **主题模式**：亮色、暗色
4. **设备类型**：iPhone、iPad

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
    center: center['功能键前景文字偏移'],
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
- `jsonnet/lib/swipeData.libsonnet` - 中文滑动数据
- `jsonnet/lib/swipeData-en.libsonnet` - 英文滑动数据

**修改方法**：

1. **修改滑动数据**（swipeData.libsonnet）：
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
    center: { x: 0.5, y: 0.35 },  // 上方位置
  }
),

spaceRightButtonForegroundStyle2: utils.makeTextStyle(
  params={
    text: '。',
    normalColor: color[theme]['按键前景颜色'],
    highlightColor: color[theme]['按键前景颜色'],
    fontSize: fontSize['按键前景文字大小'],
    center: { x: 0.5, y: 0.65 },  // 下方位置
  }
),
```

#### 示例 3：修改全局字体大小

**需求**：调整上划和下滑文字的大小

**需要修改的文件**：
- `jsonnet/lib/fontSize.libsonnet` - 字体大小配置

**修改方法**：
```jsonnet
{
  '上划文字大小': 12,  // 修改这个值
  '下划文字大小': 12,  // 修改这个值
  // ...
}
```

**影响范围**：此修改会自动应用到所有键盘类型、所有主题模式。

#### 示例 4：修改颜色主题

**需求**：调整亮色主题的按键背景颜色

**需要修改的文件**：
- `jsonnet/lib/color.libsonnet` - 颜色配置

**修改方法**：
```jsonnet
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
```

### 修改颜色

编辑 `jsonnet/lib/color.libsonnet`，修改对应主题的颜色值。

### 修改滑动操作

编辑 `jsonnet/lib/swipeData.libsonnet`（中文）或 `jsonnet/lib/swipeData-en.libsonnet`（英文）。

### 修改字体大小

编辑 `jsonnet/lib/fontSize.libsonnet`。

### 修改工具栏

编辑 `jsonnet/lib/toolbar.libsonnet`（中文）或 `jsonnet/lib/toolbar-en.libsonnet`（英文）。

### 添加新的键盘类型

1. 在 `jsonnet/keyboard/` 目录下创建新的 `.jsonnet` 文件
2. 在 `jsonnet/main.jsonnet` 中导入并生成配置
3. 在 `config.yaml` 中添加映射关系

## 注意事项

1. 修改 Jsonnet 文件后，必须重新执行构建命令生成 YAML 文件
2. 亮色和暗色主题的颜色配置需要同步修改
3. 中文和英文的滑动操作数据是分开的，需要分别修改
4. 按键尺寸和位置需要考虑不同设备的适配
5. 使用 SF Symbols 图标时，确保图标名称正确（参考 Apple 官方文档）

## 作者信息

**iPure·Pro** by Astral

---

*基于 Hamster 输入法，使用 Jsonnet 配置生成*
