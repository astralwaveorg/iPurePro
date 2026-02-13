# iPure·Pro v2 重构任务清单（完整版）

> **项目目标**：将现有的 iPure·Pro 皮肤配置重构为易维护、结构清晰、符合最佳实践的新架构
> **重构方式**：在 `v2/` 子目录中完全重构，不修改现有代码
> **验证标准**：新旧架构生成的 YAML 文件 100% 一致

---

## 📋 目录

- [项目概述](#项目概述)
- [最佳实践和规范](#最佳实践和规范)
- [新架构设计](#新架构设计)
- [详细任务清单](#详细任务清单)
- [测试策略](#测试策略)
- [验收标准](#验收标准)
- [参考资料](#参考资料)

---

## 📊 项目概述

### 当前架构问题

#### 1. 数据分散
- 配置分布在 15+ 个 libsonnet 文件中
- 相同类型的配置（颜色、尺寸、数据）散落各处
- 修改一个功能需要改动多个文件

#### 2. 代码重复
- 新旧两套架构并存（core/、components/ vs lib/）
- 大量重复的配置定义
- 中英文数据通过覆盖模式实现，存在冗余

#### 3. 命名不一致
- 中文字符串键名（如 `'字母键背景颜色-普通'`）
- 英文嵌套结构（如 `alphabeticKey.backgroundNormal`）
- 混合使用，增加维护难度

#### 4. 依赖混乱
- 文件间存在复杂的交叉引用
- 循环依赖风险
- 难以追踪配置来源

#### 5. 维护困难
- 缺少清晰的注释和文档
- 配置层次不明确
- 新增功能需要深入了解整个项目

### 新架构目标

#### 1. 单一数据源
- 所有配置集中在 `config/` 目录
- 所有数据集中在 `data/` 目录
- 修改功能只需改一处

#### 2. 清晰分层
```
presentation/  (键盘定义)
    ↓ depends on
domain/        (数据和配置)
    ↓ depends on
infrastructure/ (工具函数)
```

#### 3. 统一命名
- 使用英文命名
- 遵循统一的命名规范
- 提高代码可读性

#### 4. 易于维护
- 清晰的文件组织
- 详细的注释
- 完善的文档

#### 5. 完全兼容
- 输出与旧架构 100% 一致
- 功能完全对等
- 性能不降低

---

## 🎯 最佳实践和规范

### 1. 目录结构设计规范

#### 1.1 分层架构原则

```
jsonnet/v2/
├── presentation/           # 表现层：键盘定义和布局
│   ├── keyboards/          # 键盘定义
│   └── layouts/            # 布局定义
├── domain/                 # 领域层：配置和数据
│   ├── config/             # 配置中心
│   └── data/               # 数据中心
├── infrastructure/         # 基础设施层：工具函数
│   ├── styles/             # 样式生成器
│   ├── utils/              # 工具函数
│   └── constants/          # 常量定义
└── main.jsonnet            # 主入口
```

#### 1.2 单一职责原则

每个文件/模块只负责一个明确的功能：

- **config/** - 静态配置，不包含逻辑
- **data/** - 动态数据，不包含计算
- **styles/** - 样式生成函数，无副作用
- **utils/** - 通用工具函数，纯函数
- **keyboards/** - 键盘定义，组合配置

#### 1.3 依赖原则

- **单向依赖**：presentation → domain → infrastructure
- **避免循环依赖**：基础设施层不能依赖上层
- **最小化依赖**：每个模块只依赖必要的其他模块

#### 1.4 模块化设计

```jsonnet
// ✅ 好的设计：模块化、可复用
local theme = import "domain/config/theme";
local buttonStyles = import "infrastructure/styles/button";
local layouts = import "presentation/layouts/alphabetic";

{
  new(themeName, orientation):
    theme.getTheme(themeName) +
    buttonStyles.genAlphabetic(themeName) +
    layouts.getLayout(orientation)
}

// ❌ 不好的设计：耦合、难维护
{
  new(themeName, orientation):
    // 直接在这里定义所有样式和布局
    {
      qButton: { /* ... */ },
      wButton: { /* ... */ },
      // ...
    }
}
```

### 2. 命名规范

#### 2.1 文件命名

- **kebab-case**（小写字母和连字符）
- 描述性强，清晰表达文件内容
- 示例：`pinyin-26-keyboard.jsonnet`、`button-styles.libsonnet`

#### 2.2 导出命名

- **键盘/布局**：PascalCase（大驼峰）
- **配置对象**：camelCase（小驼峰）
- **常量**：UPPER_SNAKE_CASE

#### 2.3 函数命名

- **动词开头**，描述函数功能
- **camelCase**（小驼峰）
- 示例：`createButton()`、`generateStyles()`、`getTheme()`

#### 2.4 变量命名

- **camelCase**（小驼峰）
- 描述性强，避免缩写
- 示例：`backgroundNormal`、`fontSizeLarge`、`offsetSwipeUp`

#### 2.5 命名示例对比

```jsonnet
// ✅ 好的命名
alphabeticKey {
  backgroundNormal: "#FFFFFF",
  backgroundHighlight: "#ABB0BA",
  textNormal: "#000000",
}

function createButton(params) { /* ... */ }
const DEFAULT_FONT_SIZE = 18;

// ❌ 不好的命名
'字母键背景颜色-普通': "#FFFFFF",
background_normal: "#FFFFFF",
btnCreate: function(params) { /* ... */ },
fontSize1: 18,
```

### 3. 配置管理规范

#### 3.1 配置层次

```
1. Constants (常量)
   - 不可变的数值
   - 系统级常量

2. Dimensions (尺寸)
   - 设备相关的尺寸
   - 字体大小
   - 位置偏移

3. Theme (主题)
   - 颜色配置
   - 外观样式

4. Data (数据)
   - 滑动数据
   - 长按数据
   - 集合数据
```

#### 3.2 配置复用

**继承模式**：基类 + 派生类

```jsonnet
// ✅ 好的设计：使用继承
local baseButtonStyles = {
  normal: { /* ... */ },
  highlight: { /* ... */ },
};

{
  alphabeticButtonStyles: baseButtonStyles + {
    // 覆盖特定样式
  },
  functionButtonStyles: baseButtonStyles + {
    // 覆盖特定样式
  },
}

// ❌ 不好的设计：重复定义
{
  alphabeticButtonStyles: {
    normal: { /* ... */ },
    highlight: { /* ... */ },
  },
  functionButtonStyles: {
    normal: { /* ... */ },  // 重复
    highlight: { /* ... */ },  // 重复
  },
}
```

**Mixin 模式**：组合多个配置

```jsonnet
// ✅ 好的设计：使用 mixin 组合
local withAnimation = mixin(styles): styles + { animation: "scale" };
local withNotification = mixin(styles): styles + { notification: [...] };

{
  qButton: withAnimation(withNotification({ /* ... */ })),
}

// ❌ 不好的设计：每次都写完整的配置
{
  qButton: {
    size: { /* ... */ },
    action: { /* ... */ },
    animation: "scale",
    notification: [...],
    // ...
  },
}
```

#### 3.3 避免硬编码

```jsonnet
// ✅ 好的设计：使用常量
local CONSTANTS = import "infrastructure/constants/common";

{
  fontSize: CONSTANTS.DEFAULT_FONT_SIZE,
  cornerRadius: CONSTANTS.BUTTON_CORNER_RADIUS,
}

// ❌ 不好的设计：硬编码
{
  fontSize: 18,
  cornerRadius: 7,
}
```

### 4. 性能优化规范

#### 4.1 减少重复计算

```jsonnet
// ✅ 好的设计：缓存计算结果
local genAlphabeticStyles(theme) =
  local base = { /* ... */ };
  local keys = ["q", "w", "e", /* ... */];
  std.foldl(function(acc, key) acc + { [key + "ButtonForegroundStyle"]: base }, keys, {});

// ❌ 不好的设计：每次都重新计算
{
  qButtonForegroundStyle: { /* ... */ },
  wButtonForegroundStyle: { /* ... */ },
  // ... 重复26次
}
```

#### 4.2 优化数据结构

```jsonnet
// ✅ 好的设计：使用对象查找
local getSwipeAction(key) = std.objectHas(swipeData, key) ? swipeData[key] : null;

// ❌ 不好的设计：使用条件判断
local getSwipeAction(key) =
  if key == "q" then swipeData.q
  else if key == "w" then swipeData.w
  else if key == "e" then swipeData.e
  // ... 26个条件
  else null;
```

#### 4.3 延迟计算

```jsonnet
// ✅ 好的设计：按需计算
{
  new(theme, orientation):
    local config = getConfig(theme);
    local layout = getLayout(orientation);
    config + layout + getKeyboardSpecific(theme, orientation)
}

// ❌ 不好的设计：提前计算所有组合
{
  portraitLight: { /* ... */ },
  portraitDark: { /* ... */ },
  landscapeLight: { /* ... */ },
  landscapeDark: { /* ... */ },
}
```

### 5. 代码质量规范

#### 5.1 注释规范

每个文件头部必须包含：

```jsonnet
/*
 * 文件名：theme.libsonnet
 * 功能：定义主题配置（亮色/暗色）
 * 作者：iPure·Pro Team
 * 更新时间：2026-02-13
 *
 * 说明：
 * - 包含亮色和暗色两种主题
 * - 支持字母键、功能键、回车键等配置
 * - 颜色值使用十六进制格式 (#RRGGBB)
 */
```

每个重要配置项必须包含注释：

```jsonnet
{
  light: {
    // 字母键背景颜色
    alphabeticKey: {
      // 普通状态背景色
      backgroundNormal: "#FFFFFF",
      // 高亮状态背景色
      backgroundHighlight: "#ABB0BA",
    },
  },
}
```

#### 5.2 函数注释

```jsonnet
/*
 * 创建文本样式
 *
 * @param params - 样式参数
 *   - text: 文本内容
 *   - fontSize: 字体大小
 *   - normalColor: 普通状态颜色
 *   - highlightColor: 高亮状态颜色
 *   - center: 文本位置 {x, y}
 * @returns 样式对象
 */
function makeTextStyle(params) { /* ... */ }
```

#### 5.3 代码格式

- 使用 2 空格缩进
- 每行不超过 120 字符
- 对象和数组的最后一个元素后有逗号
- 操作符前后有空格

```jsonnet
// ✅ 好的格式
{
  light: {
    alphabeticKey: {
      backgroundNormal: "#FFFFFF",
      backgroundHighlight: "#ABB0BA",
    },
  },
}

// ❌ 不好的格式
{light:{alphabeticKey:{backgroundNormal:"#FFFFFF",backgroundHighlight:"#ABB0BA"}}}
```

### 6. 测试规范

#### 6.1 测试覆盖

- **单元测试**：每个工具函数
- **集成测试**：每个键盘类型
- **对比测试**：新旧架构输出对比
- **功能测试**：实际使用场景

#### 6.2 测试数据

准备测试用例：

```jsonnet
// test/fixtures/test-cases.jsonnet
{
  pinyinKeyboard: {
    portrait: {
      light: "light/pinyin_26_portrait.yaml",
      dark: "dark/pinyin_26_portrait.yaml",
    },
    landscape: {
      light: "light/pinyin_26_landscape.yaml",
      dark: "dark/pinyin_26_landscape.yaml",
    },
  },
  // ... 其他键盘
}
```

#### 6.3 自动化测试

编写测试脚本：

```bash
#!/bin/bash
# test/test-output.sh

echo "Compiling old architecture..."
jsonnet -S -m temp/old jsonnet/main.jsonnet

echo "Compiling new architecture..."
jsonnet -S -m temp/new jsonnet/v2/main.jsonnet

echo "Comparing outputs..."
diff -r temp/old temp/new

if [ $? -eq 0 ]; then
  echo "✅ All outputs match!"
else
  echo "❌ Outputs differ!"
  exit 1
fi
```

### 7. 文档规范

#### 7.1 README 文档

每个目录包含 README.md：

```markdown
# Config Directory

主题配置目录。

## 文件说明

- `theme.libsonnet` - 主题配置（亮色/暗色）
- `dimensions.libsonnet` - 尺寸配置
- `animation.libsonnet` - 动画配置
- `others.libsonnet` - 其他配置

## 使用方法

```jsonnet
local config = import "domain/config";
local theme = config.theme.light;
```

## 注意事项

- 颜色值使用十六进制格式
- 主题配置不包含逻辑
- 修改主题需同时修改亮色和暗色
```

#### 7.2 API 文档

为导出的函数编写文档：

```markdown
# Style Generator API

样式生成器工具函数。

## 函数列表

### makeTextStyle(params)

创建文本样式。

**参数：**
- `params.text` (String) - 文本内容
- `params.fontSize` (Number) - 字体大小
- `params.normalColor` (String) - 普通状态颜色
- `params.highlightColor` (String) - 高亮状态颜色
- `params.center` (Object) - 文本位置 {x, y}

**返回值：** Object - 样式对象

**示例：**
```jsonnet
makeTextStyle({
  text: "A",
  fontSize: 18,
  normalColor: "#000000",
  highlightColor: "#FFFFFF",
  center: {x: 0.5, y: 0.5}
})
```
```

---

## 🏗️ 新架构设计

### 目录结构

```
v2/
├── main.jsonnet                    # 主入口，生成所有配置
│
├── presentation/                   # 表现层：键盘定义
│   ├── keyboards/                  # 键盘定义
│   │   ├── index.libsonnet        # 导出所有键盘
│   │   ├── pinyin-26.jsonnet      # 拼音键盘
│   │   ├── alphabetic-26.jsonnet  # 字母键盘
│   │   ├── numeric-9.jsonnet      # 数字键盘
│   │   ├── symbolic.jsonnet       # 符号键盘
│   │   └── panel.jsonnet          # 面板键盘
│   │
│   └── layouts/                    # 布局定义
│       ├── index.libsonnet        # 导出所有布局
│       ├── alphabetic.libsonnet    # 字母键盘布局
│       ├── numeric.libsonnet      # 数字键盘布局
│       └── symbolic.libsonnet     # 符号键盘布局
│
├── domain/                         # 领域层：配置和数据
│   ├── config/                     # 配置中心
│   │   ├── index.libsonnet        # 导出所有配置
│   │   ├── theme.libsonnet        # 主题配置
│   │   ├── dimensions.libsonnet   # 尺寸配置
│   │   ├── animation.libsonnet    # 动画配置
│   │   └── others.libsonnet       # 其他配置
│   │
│   └── data/                       # 数据中心
│       ├── index.libsonnet        # 导出所有数据
│       ├── swipe.libsonnet        # 滑动数据
│       ├── hint.libsonnet         # 长按数据
│       ├── collection.libsonnet   # 集合数据
│       └── toolbar.libsonnet      # 工具栏数据
│
└── infrastructure/                 # 基础设施层：工具函数
    ├── styles/                     # 样式生成器
    │   ├── index.libsonnet        # 导出所有样式函数
    │   ├── text.libsonnet         # 文本样式
    │   ├── image.libsonnet        # 图片样式
    │   ├── geometry.libsonnet     # 几何样式
    │   └── button.libsonnet       # 按钮样式
    │
    ├── utils/                      # 工具函数
    │   ├── index.libsonnet        # 导出所有工具函数
    │   ├── button.libsonnet       # 按键创建
    │   ├── style.libsonnet        # 样式生成
    │   └── layout.libsonnet       # 布局计算
    │
    └── constants/                  # 常量定义
        ├── index.libsonnet        # 导出所有常量
        ├── common.libsonnet       # 通用常量
        ├── font.libsonnet         # 字体常量
        └── size.libsonnet         # 尺寸常量
```

### 模块依赖关系

```
main.jsonnet
    ↓ imports
presentation/keyboards/
    ↓ imports
presentation/layouts/
    ↓ imports
domain/config/
domain/data/
    ↓ imports
infrastructure/styles/
infrastructure/utils/
infrastructure/constants/
```

### 文件职责

#### 表现层 (presentation/)

- **keyboards/** - 定义键盘的按键布局和样式
- **layouts/** - 定义键盘的布局结构（VStack/HStack）

#### 领域层 (domain/)

- **config/** - 所有静态配置（主题、尺寸、动画）
- **data/** - 所有动态数据（滑动、长按、集合）

#### 基础设施层 (infrastructure/)

- **styles/** - 样式生成函数（无状态）
- **utils/** - 通用工具函数（纯函数）
- **constants/** - 系统常量（不可变）

---

## 📝 详细任务清单

### 阶段 1：准备和分析

#### 1.1 项目分析

- [x] 阅读官方文档
  - [x] 皮肤结构
  - [x] 布局系统
  - [x] 样式系统
  - [x] 动作系统
  - [x] 动画系统
  - [x] 通知系统
  - [x] 集合视图
  - [x] 预编辑区
  - [x] 配置参数

- [x] 分析现有项目结构
  - [x] 识别所有配置项（颜色、尺寸、数据）
  - [x] 识别重复代码
  - [x] 识别未使用配置
  - [x] 分析依赖关系
  - [x] 分析文件职责

- [x] 创建文档
  - [x] TASK.md（本文件）
  - [x] .iflowignore

#### 1.2 设计新架构

- [x] 设计分层架构
  - [x] 表现层 (presentation/)
  - [x] 领域层 (domain/)
  - [x] 基础设施层 (infrastructure/)

- [x] 定义命名规范
  - [x] 文件命名
  - [x] 导出命名
  - [x] 函数命名
  - [x] 变量命名

- [x] 定义代码规范
  - [x] 注释规范
  - [x] 格式规范
  - [x] 性能规范
  - [x] 测试规范

### 阶段 2：创建基础结构

#### 2.1 创建目录结构

- [ ] 创建 `v2/` 目录
- [ ] 创建 `v2/presentation/` 目录
  - [ ] 创建 `presentation/keyboards/` 目录
  - [ ] 创建 `presentation/layouts/` 目录
- [ ] 创建 `v2/domain/` 目录
  - [ ] 创建 `domain/config/` 目录
  - [ ] 创建 `domain/data/` 目录
- [ ] 创建 `v2/infrastructure/` 目录
  - [ ] 创建 `infrastructure/styles/` 目录
  - [ ] 创建 `infrastructure/utils/` 目录
  - [ ] 创建 `infrastructure/constants/` 目录

#### 2.2 创建索引文件

- [ ] 创建 `presentation/keyboards/index.libsonnet`
  - [ ] 导出所有键盘构造函数
  - [ ] 提供统一的键盘访问接口

- [ ] 创建 `presentation/layouts/index.libsonnet`
  - [ ] 导出所有布局函数
  - [ ] 提供统一的布局访问接口

- [ ] 创建 `domain/config/index.libsonnet`
  - [ ] 导出所有配置
  - [ ] 提供统一的配置访问接口

- [ ] 创建 `domain/data/index.libsonnet`
  - [ ] 导出所有数据
  - [ ] 提供统一的数据访问接口

- [ ] 创建 `infrastructure/styles/index.libsonnet`
  - [ ] 导出所有样式函数
  - [ ] 提供统一的样式访问接口

- [ ] 创建 `infrastructure/utils/index.libsonnet`
  - [ ] 导出所有工具函数
  - [ ] 提供统一的工具访问接口

- [ ] 创建 `infrastructure/constants/index.libsonnet`
  - [ ] 导出所有常量
  - [ ] 提供统一的常量访问接口

#### 2.3 创建 README 文档

- [ ] 创建 `presentation/keyboards/README.md`
- [ ] 创建 `presentation/layouts/README.md`
- [ ] 创建 `domain/config/README.md`
- [ ] 创建 `domain/data/README.md`
- [ ] 创建 `infrastructure/styles/README.md`
- [ ] 创建 `infrastructure/utils/README.md`
- [ ] 创建 `infrastructure/constants/README.md`

### 阶段 3：迁移基础设施层

#### 3.1 常量定义 (constants/)

- [ ] 创建 `common.libsonnet`
  - [ ] 定义通用常量
    - [ ] `DEFAULT_ANIMATION_DURATION`
    - [ ] `DEFAULT_BUTTON_CORNER_RADIUS`
    - [ ] `DEFAULT_BUTTON_INSETS`
  - [ ] 添加详细注释

- [ ] 创建 `font.libsonnet`
  - [ ] 定义字体常量
    - [ ] 从 `lib/fontSize.libsonnet` 迁移所有字体大小
  - [ ] 分类组织
    - [ ] 候选字体
    - [ ] 预编辑字体
    - [ ] 滑动字体
    - [ ] 气泡字体
    - [ ] 按键字体
    - [ ] 工具栏字体
  - [ ] 统一命名

- [ ] 创建 `size.libsonnet`
  - [ ] 定义尺寸常量
    - [ ] 从 `lib/center.libsonnet` 迁移所有偏移量
  - [ ] 分类组织
    - [ ] 滑动偏移
    - [ ] 气泡偏移
    - [ ] 前景偏移
    - [ ] 工具栏偏移
    - [ ] 缩放比例
  - [ ] 统一命名

#### 3.2 样式生成器 (styles/)

- [ ] 创建 `text.libsonnet`
  - [ ] 实现 `makeTextStyle()` 函数
  - [ ] 参数说明
    - [ ] `text` - 文本内容
    - [ ] `fontSize` - 字体大小
    - [ ] `fontWeight` - 字体粗细
    - [ ] `normalColor` - 普通状态颜色
    - [ ] `highlightColor` - 高亮状态颜色
    - [ ] `center` - 文本位置
  - [ ] 从 `lib/utils.libsonnet` 提取
  - [ ] 添加参数验证

- [ ] 创建 `image.libsonnet`
  - [ ] 实现 `makeSystemImageStyle()` 函数
  - [ ] 实现 `makeAssetImageStyle()` 函数
  - [ ] 实现 `makeFileImageStyle()` 函数
  - [ ] 参数说明
    - [ ] `systemImageName` / `assetImageName` / `file`
    - [ ] `fontSize` / `contentMode`
    - [ ] `normalColor` / `highlightColor`
    - [ ] `insets`
  - [ ] 从 `lib/utils.libsonnet` 提取
  - [ ] 添加参数验证

- [ ] 创建 `geometry.libsonnet`
  - [ ] 实现 `makeGeometryStyle()` 函数
  - [ ] 参数说明
    - [ ] `buttonStyleType` - 样式类型
    - [ ] `normalColor` / `highlightColor`
    - [ ] `cornerRadius`
    - [ ] `insets`
    - [ ] `borderSize` / `normalBorderColor` / `highlightBorderColor`
    - [ ] `normalLowerEdgeColor` / `highlightLowerEdgeColor`
    - [ ] `normalShadowColor` / `highlightShadowColor`
    - [ ] `shadowRadius` / `shadowOffset` / `shadowOpacity`
  - [ ] 从 `lib/utils.libsonnet` 提取
  - [ ] 添加参数验证

- [ ] 创建 `button.libsonnet`
  - [ ] 实现 `createButton()` 函数
  - [ ] 参数说明
    - [ ] `key` - 按键标识
    - [ ] `size` - 按键尺寸
    - [ ] `bounds` - 按键边界
    - [ ] `backgroundStyle` - 背景样式
    - [ ] `foregroundStyle` - 前景样式
    - [ ] `action` - 按键动作
    - [ ] `swipeUpAction` - 上滑动作
    - [ ] `swipeDownAction` - 下滑动作
    - [ ] `hintSymbolsStyle` - 长按提示样式
    - [ ] `animation` - 动画
    - [ ] `notification` - 通知
  - [ ] 从 `lib/utils.libsonnet` 提取
  - [ ] 添加参数验证

#### 3.3 工具函数 (utils/)

- [ ] 创建 `button.libsonnet`
  - [ ] 实现 `genAlphabeticStyles()` 函数
    - [ ] 批量生成字母键样式
    - [ ] 接收主题参数
    - [ ] 返回样式对象
  - [ ] 实现 `genPinyinStyles()` 函数
    - [ ] 批量生成拼音键样式
    - [ ] 接收主题参数
    - [ ] 返回样式对象
  - [ ] 实现 `genNumberStyles()` 函数
    - [ ] 批量生成数字键样式
    - [ ] 接收主题参数
    - [ ] 返回样式对象
  - [ ] 实现 `genHintStyles()` 函数
    - [ ] 批量生成提示样式
    - [ ] 接收主题参数
    - [ ] 返回样式对象
  - [ ] 从 `lib/utils.libsonnet` 提取
  - [ ] 优化性能（使用 foldl）

- [ ] 创建 `style.libsonnet`
  - [ ] 实现 `mergeStyles()` 函数
    - [ ] 合并多个样式
    - [ ] 处理冲突
  - [ ] 实现 `cloneStyle()` 函数
    - [ ] 克隆样式对象
    - [ ] 深度复制

- [ ] 创建 `layout.libsonnet`
  - [ ] 实现 `getPortraitLayout()` 函数
    - [ ] 返回竖屏布局
    - [ ] 接收键盘类型参数
  - [ ] 实现 `getLandscapeLayout()` 函数
    - [ ] 返回横屏布局
    - [ ] 接收键盘类型参数
  - [ ] 实现 `getButtonSize()` 函数
    - [ ] 返回按键尺寸
    - [ ] 接收方向参数
  - [ ] 从 `lib/keyboardLayout.libsonnet` 提取
  - [ ] 优化性能

### 阶段 4：迁移领域层

#### 4.1 配置中心 (config/)

- [ ] 创建 `theme.libsonnet`
  - [ ] 定义主题配置结构
  - [ ] 从 `lib/color.libsonnet` 迁移
  - [ ] 重构为英文命名
  - [ ] 分类组织
    - [ ] `alphabeticKey` - 字母键
    - [ ] `functionKey` - 功能键
    - [ ] `enterKey` - 回车键
    - [ ] `bubble` - 气泡
    - [ ] `lowerEdge` - 底边缘
    - [ ] `longPress` - 长按
    - [ ] `candidate` - 候选
    - [ ] `toolbar` - 工具栏
    - [ ] `numeric` - 数字键盘
    - [ ] `symbolic` - 符号键盘
    - [ ] `panel` - 面板键盘
  - [ ] 定义亮色和暗色主题
  - [ ] 添加详细注释
  - [ ] 验证颜色值格式

- [ ] 创建 `dimensions.libsonnet`
  - [ ] 定义尺寸配置结构
  - [ ] 从 `lib/fontSize.libsonnet` 和 `lib/center.libsonnet` 迁移
  - [ ] 分类组织
    - [ ] `fontSize` - 字体大小
    - [ ] `offset` - 位置偏移
    - [ ] `buttonSize` - 按键尺寸
  - [ ] 定义竖屏和横屏配置
  - [ ] 添加详细注释
  - [ ] 验证数值范围

- [ ] 创建 `animation.libsonnet`
  - [ ] 定义动画配置
  - [ ] 从 `lib/animation.libsonnet` 迁移
  - [ ] 分类组织
    - [ ] `scaleAnimation` - 缩放动画
    - [ ] `cartoonAnimation` - 卡通动画
    - [ ] `physicsAnimation` - 物理动画
  - [ ] 添加详细注释
  - [ ] 验证动画参数

- [ ] 创建 `others.libsonnet`
  - [ ] 定义其他配置
  - [ ] 从 `lib/others.libsonnet` 迁移
  - [ ] 分类组织
    - [ ] `heights` - 高度配置
    - [ ] `rimeSchema` - RIME 方案
  - [ ] 定义竖屏和横屏配置
  - [ ] 添加详细注释
  - [ ] 验证配置值

#### 4.2 数据中心 (data/)

- [ ] 创建 `swipe.libsonnet`
  - [ ] 定义滑动数据结构
  - [ ] 从 `lib/swipeData.libsonnet` 和 `lib/swipeData-en.libsonnet` 迁移
  - [ ] 分类组织
    - [ ] `chinese` - 中文滑动数据
      - [ ] `up` - 上滑操作
      - [ ] `down` - 下滑操作
    - [ ] `english` - 英文滑动数据
      - [ ] `up` - 上滑操作（覆盖差异）
      - [ ] `down` - 下滑操作（覆盖差异）
  - [ ] 合并重复配置
  - [ ] 添加详细注释
  - [ ] 验证动作类型

- [ ] 创建 `hint.libsonnet`
  - [ ] 定义长按提示数据结构
  - [ ] 从 `lib/hintSymbolsData.libsonnet` 迁移
  - [ ] 分类组织
    - [ ] `pinyin` - 拼音键盘长按
    - [ ] `numeric` - 数字键盘长按
    - [ ] `cn9` - 中文九键长按
  - [ ] 重构键名（`123` → `number`）
  - [ ] 添加详细注释
  - [ ] 验证列表项

- [ ] 创建 `collection.libsonnet`
  - [ ] 定义集合数据结构
  - [ ] 从 `lib/collectionData.libsonnet` 迁移
  - [ ] 分类组织
    - [ ] `numericSymbols` - 数字键盘符号
    - [ ] `symbolicCategories` - 符号键盘分类
  - [ ] 添加详细注释
  - [ ] 验证数据格式

- [ ] 创建 `toolbar.libsonnet`
  - [ ] 定义工具栏数据结构
  - [ ] 从 `lib/toolbar.libsonnet` 和 `lib/toolbar-en.libsonnet` 迁移
  - [ ] 分类组织
    - [ ] `chinese` - 中文工具栏
    - [ ] `english` - 英文工具栏
  - [ ] 合并重复配置
  - [ ] 添加详细注释
  - [ ] 验证图标名称

### 阶段 5：迁移表现层

#### 5.1 布局定义 (layouts/)

- [ ] 创建 `alphabetic.libsonnet`
  - [ ] 定义字母键盘布局
  - [ ] 从 `lib/keyboardLayout.libsonnet` 提取
  - [ ] 实现竖屏布局
  - [ ] 实现横屏布局
  - [ ] 添加详细注释
  - [ ] 验证布局结构

- [ ] 创建 `numeric.libsonnet`
  - [ ] 定义数字键盘布局
  - [ ] 从 `keyboard/numeric_9_portrait.jsonnet` 提取
  - [ ] 实现竖屏布局
  - [ ] 实现横屏布局
  - [ ] 添加详细注释
  - [ ] 验证布局结构

- [ ] 创建 `symbolic.libsonnet`
  - [ ] 定义符号键盘布局
  - [ ] 从 `keyboard/symbolic_portrait.jsonnet` 提取
  - [ ] 实现分类布局
  - [ ] 添加详细注释
  - [ ] 验证布局结构

#### 5.2 键盘定义 (keyboards/)

- [ ] 创建 `pinyin-26.jsonnet`
  - [ ] 导入依赖
    - [ ] domain/config
    - [ ] domain/data
    - [ ] infrastructure/styles
    - [ ] infrastructure/utils
    - [ ] presentation/layouts
  - [ ] 定义键盘构造函数 `new(theme, orientation)`
  - [ ] 定义按键布局
    - [ ] 第一行：q-w-e-r-t-y-u-i-o-p
    - [ ] 第二行：a-s-d-f-g-h-j-k-l
    - [ ] 第三行：shift-z-x-c-v-b-n-m-backspace
    - [ ] 第四行：EnZh-symbol-number-space-spaceRight-enter
  - [ ] 定义按键样式
    - [ ] 26个字母键
    - [ ] 功能键
  - [ ] 定义滑动操作
  - [ ] 定义长按提示
  - [ ] 定义动画
  - [ ] 定义通知
  - [ ] 添加详细注释
  - [ ] 验证所有按键

- [ ] 创建 `alphabetic-26.jsonnet`
  - [ ] 导入拼音键盘
  - [ ] 定义键盘构造函数 `new(theme, orientation)`
  - [ ] 覆盖英文特定配置
    - [ ] 使用英文滑动数据
    - [ ] 使用英文工具栏
  - [ ] 添加详细注释
  - [ ] 验证配置差异

- [ ] 创建 `numeric-9.jsonnet`
  - [ ] 导入依赖
  - [ ] 定义键盘构造函数 `new(theme, orientation)`
  - [ ] 定义按键布局
    - [ ] 集合视图（左侧符号）
    - [ ] 数字键
    - [ ] 其他键
  - [ ] 支持竖屏和横屏
  - [ ] 定义按键样式
  - [ ] 定义滑动操作
  - [ ] 定义长按提示
  - [ ] 添加详细注释
  - [ ] 验证所有按键

- [ ] 创建 `symbolic.jsonnet`
  - [ ] 导入依赖
  - [ ] 定义键盘构造函数 `new(theme, orientation)`
  - [ ] 定义分类符号布局
    - [ ] 一级分类列表
    - [ ] 二级分类列表
  - [ ] 定义集合样式
  - [ ] 添加详细注释
  - [ ] 验证布局结构

- [ ] 创建 `panel.jsonnet`
  - [ ] 导入依赖
  - [ ] 定义键盘构造函数 `new(theme, orientation)`
  - [ ] 定义浮动模式布局
  - [ ] 定义按键样式
  - [ ] 添加详细注释
  - [ ] 验证布局结构

### 阶段 6：创建主入口

- [ ] 创建 `main.jsonnet`
  - [ ] 导入所有键盘
  - [ ] 生成亮色主题配置
    - [ ] pinyin-26-portrait
    - [ ] pinyin-26-landscape
    - [ ] alphabetic-26-portrait
    - [ ] alphabetic-26-landscape
    - [ ] numeric-9-portrait
    - [ ] numeric-9-landscape
    - [ ] symbolic-portrait
    - [ ] panel-portrait
    - [ ] panel-landscape
  - [ ] 生成暗色主题配置
    - [ ] 同上所有项
  - [ ] 生成 config.yaml
  - [ ] 添加详细注释
  - [ ] 验证输出格式

---

## 🧪 测试策略

### 1. 单元测试

#### 1.1 样式生成函数测试

测试文件：`test/unit/test-styles.libsonnet`

```jsonnet
local makeTextStyle = import "../../infrastructure/styles/text";

{
  testMakeTextStyle: {
    // 测试基本文本样式
    basic: makeTextStyle({
      text: "A",
      fontSize: 18,
      normalColor: "#000000",
      highlightColor: "#FFFFFF",
    }),
    // 测试带位置的文本样式
    withCenter: makeTextStyle({
      text: "B",
      fontSize: 20,
      normalColor: "#000000",
      highlightColor: "#FFFFFF",
      center: {x: 0.5, y: 0.5},
    }),
  },
}
```

#### 1.2 工具函数测试

测试文件：`test/unit/test-utils.libsonnet`

```jsonnet
local genAlphabeticStyles = import "../../infrastructure/utils/button";

{
  testGenAlphabeticStyles: {
    light: genAlphabeticStyles("light"),
    dark: genAlphabeticStyles("dark"),
  },
}
```

### 2. 集成测试

#### 2.1 键盘配置测试

测试文件：`test/integration/test-keyboards.libsonnet`

```jsonnet
local keyboards = import "../../presentation/keyboards";

{
  testPinyinKeyboard: {
    portraitLight: keyboards.pinyin26.new("light", "portrait"),
    portraitDark: keyboards.pinyin26.new("dark", "portrait"),
    landscapeLight: keyboards.pinyin26.new("light", "landscape"),
    landscapeDark: keyboards.pinyin26.new("dark", "landscape"),
  },
  testAlphabeticKeyboard: {
    portraitLight: keyboards.alphabetic26.new("light", "portrait"),
    portraitDark: keyboards.alphabetic26.new("dark", "portrait"),
  },
  testNumericKeyboard: {
    portraitLight: keyboards.numeric9.new("light", "portrait"),
    portraitDark: keyboards.numeric9.new("dark", "portrait"),
  },
  testSymbolicKeyboard: {
    portraitLight: keyboards.symbolic.new("light", "portrait"),
    portraitDark: keyboards.symbolic.new("dark", "portrait"),
  },
  testPanelKeyboard: {
    portraitLight: keyboards.panel.new("light", "portrait"),
    landscapeLight: keyboards.panel.new("light", "landscape"),
  },
}
```

### 3. 对比测试

#### 3.1 编译新旧架构

```bash
#!/bin/bash
# test/compare.sh

echo "=== 编译旧架构 ==="
mkdir -p temp/old
jsonnet -S -m temp/old jsonnet/main.jsonnet

echo "=== 编译新架构 ==="
mkdir -p temp/new
jsonnet -S -m temp/new v2/main.jsonnet

echo "=== 对比输出 ==="
diff -r temp/old temp/new

if [ $? -eq 0 ]; then
  echo "✅ 所有输出一致！"
  exit 0
else
  echo "❌ 输出存在差异！"
  echo "请检查以下文件："
  diff -r temp/old temp/new | head -50
  exit 1
fi
```

#### 3.2 逐文件对比

```bash
#!/bin/bash
# test/compare-files.sh

FILES=(
  "light/pinyin_26_portrait.yaml"
  "light/pinyin_26_landscape.yaml"
  "light/alphabetic_26_portrait.yaml"
  "light/alphabetic_26_landscape.yaml"
  "light/numeric_9_portrait.yaml"
  "light/numeric_9_landscape.yaml"
  "light/symbolic_portrait.yaml"
  "light/panel_portrait.yaml"
  "light/panel_landscape.yaml"
  "dark/pinyin_26_portrait.yaml"
  "dark/pinyin_26_landscape.yaml"
  "dark/alphabetic_26_portrait.yaml"
  "dark/alphabetic_26_landscape.yaml"
  "dark/numeric_9_portrait.yaml"
  "dark/numeric_9_landscape.yaml"
  "dark/symbolic_portrait.yaml"
  "dark/panel_portrait.yaml"
  "dark/panel_landscape.yaml"
  "config.yaml"
)

echo "=== 逐文件对比 ==="
for file in "${FILES[@]}"; do
  echo "对比 $file ..."
  diff "temp/old/$file" "temp/new/$file"
  if [ $? -ne 0 ]; then
    echo "❌ $file 存在差异！"
    exit 1
  fi
done

echo "✅ 所有文件一致！"
```

### 4. 功能测试

#### 4.1 测试用例

测试文件：`test/functional/test-cases.md`

```markdown
# 功能测试用例

## 1. 拼音键盘

### 1.1 竖屏亮色
- [ ] 显示26个字母键
- [ ] 显示Shift键（初始状态）
- [ ] 显示Backspace键
- [ ] 显示空格键
- [ ] 显示逗号/句号键
- [ ] 显示回车键
- [ ] 点击字母键输入拼音
- [ ] 长按字母键显示候选字符
- [ ] 上滑字母键显示符号
- [ ] 下滑字母键显示符号
- [ ] 按Shift键切换大写状态
- [ ] 双击Shift键锁定大写
- [ ] 回车键显示默认文本
- [ ] 按键有按下效果

### 1.2 竖屏暗色
- [ ] (同竖屏亮色所有测试)

### 1.3 横屏亮色
- [ ] 布局适应横屏
- [ ] (同竖屏亮色所有测试)

### 1.4 横屏暗色
- [ ] 布局适应横屏
- [ ] (同竖屏暗色所有测试)

## 2. 字母键盘

### 2.1 竖屏亮色
- [ ] 显示26个字母键
- [ ] 长按字母键显示英文候选
- [ ] 上滑显示符号
- [ ] 下滑显示符号
- [ ] 滑动操作与拼音键盘不同
- [ ] 工具栏图标与拼音键盘不同

## 3. 数字键盘

### 3.1 竖屏亮色
- [ ] 显示左侧符号集合
- [ ] 显示1-9数字键
- [ ] 显示0键
- [ ] 显示符号键（切换到字母键盘）
- [ ] 显示空格键
- [ ] 显示等号键
- [ ] 显示句号键
- [ ] 显示Backspace键
- [ ] 显示返回键
- [ ] 点击符号集合项输入符号
- [ ] 长按数字键显示中文数字
- [ ] 滑动操作正常
- [ ] 符号键显示"英"

## 4. 符号键盘

### 4.1 竖屏亮色
- [ ] 显示一级分类
- [ ] 点击分类显示二级符号
- [ ] 符号可滚动
- [ ] 返回键返回拼音键盘

## 5. 面板键盘

### 5.1 竖屏亮色
- [ ] 显示浮动模式布局
- [ ] 按键尺寸较小
- [ ] 点击输入后自动关闭

## 6. 智能回车键

- [ ] 搜索框显示"搜索"
- [ ] 发送框显示"发送"
- [ ] 网页框显示"前往"
- [ ] 普通框显示"换行"
```

#### 4.2 测试脚本

```bash
#!/bin/bash
# test/functional/test.sh

echo "=== 功能测试清单 ==="
echo "请在元输入法中测试以下功能："
echo ""
echo "1. 拼音键盘（竖屏/横屏、亮色/暗色）"
echo "2. 字母键盘（竖屏/横屏、亮色/暗色）"
echo "3. 数字键盘（竖屏/横屏、亮色/暗色）"
echo "4. 符号键盘（竖屏、亮色/暗色）"
echo "5. 面板键盘（竖屏/横屏、亮色/暗色）"
echo "6. 智能回车键"
echo ""
echo "详细测试用例请参考：test/functional/test-cases.md"
```

### 5. 性能测试

#### 5.1 编译时间测试

```bash
#!/bin/bash
# test/performance/compile-time.sh

echo "=== 测试旧架构编译时间 ==="
time jsonnet -S -m temp/old jsonnet/main.jsonnet

echo ""
echo "=== 测试新架构编译时间 ==="
time jsonnet -S -m temp/new v2/main.jsonnet

echo ""
echo "=== 对比 ==="
echo "新架构编译时间不应超过旧架构的 120%"
```

#### 5.2 输出大小测试

```bash
#!/bin/bash
# test/performance/output-size.sh

echo "=== 测试旧架构输出大小 ==="
du -sh temp/old

echo ""
echo "=== 测试新架构输出大小 ==="
du -sh temp/new

echo ""
echo "=== 对比 ==="
echo "新架构输出大小应与旧架构相近"
```

---

## ✅ 验收标准

### 1. 功能完整性

#### 1.1 键盘类型
- [x] 拼音键盘（pinyin-26）
- [x] 字母键盘（alphabetic-26）
- [x] 数字键盘（numeric-9）
- [x] 符号键盘（symbolic）
- [x] 面板键盘（panel）

#### 1.2 设备方向
- [x] 竖屏模式（portrait）
- [x] 横屏模式（landscape）
- [x] 浮动模式（floating）

#### 1.3 主题
- [x] 亮色主题（light）
- [x] 暗色主题（dark）

#### 1.4 交互功能
- [x] 点击输入
- [x] 上滑操作（swipeUp）
- [x] 下滑操作（swipeDown）
- [x] 长按提示（hintSymbols）
- [x] 按键动画（animation）
- [x] 通知系统（notification）

#### 1.5 特殊功能
- [x] Shift 键切换（大写/小写/锁定）
- [x] 智能回车键
- [x] 中英文切换
- [x] 工具栏功能
- [x] 集合视图

### 2. 输出一致性

#### 2.1 文件对比
- [ ] 所有 YAML 文件 100% 一致
- [ ] 使用 diff 工具验证
- [ ] 无任何差异

#### 2.2 配置对比
- [ ] 所有配置项完全相同
- [ ] 所有按键定义相同
- [ ] 所有样式定义相同

### 3. 代码质量

#### 3.1 文档
- [ ] 所有文件都有清晰的注释
- [ ] 每个目录都有 README.md
- [ ] API 文档完整

#### 3.2 命名
- [ ] 遵循统一的命名规范
- [ ] 无中文字符串键名
- [ ] 变量名描述性强

#### 3.3 结构
- [ ] 无重复代码
- [ ] 无未使用的配置
- [ ] 依赖关系清晰

#### 3.4 性能
- [ ] 编译时间不超过旧架构的 120%
- [ ] 输出文件大小与旧架构相近
- [ ] 无性能瓶颈

### 4. 可维护性

#### 4.1 易于修改
- [ ] 修改主题只需改 theme.libsonnet
- [ ] 修改尺寸只需改 dimensions.libsonnet
- [ ] 修改数据只需改 data/ 目录

#### 4.2 易于扩展
- [ ] 添加新键盘类型简单
- [ ] 添加新样式简单
- [ ] 添加新数据简单

#### 4.3 易于理解
- [ ] 代码结构清晰
- [ ] 注释详细
- [ ] 文档完善

---

## 📚 参考资料

### ⚠️ 重要说明

**元输入法** 是 **仓输入法（Hamster）** 的完全重构版本，两者在底层架构和配置方式上有很大差异。本项目基于元输入法 v3+ 开发，**所有官方文档请参考元输入法的官方文档**。

在开发过程中，遇到以下情况时**必须**查阅官方文档：
1. 不理解某个配置参数的含义
2. 需要实现新功能时查找最佳实践
3. 遇到错误或异常行为时排查问题
4. 确认 API 的正确用法

### 官方文档（元输入法 v3）

以下文档在开发过程中**随时可能需要参考**：

- [皮肤结构](https://ihsiao.com/apps/hamster/v3/docs/guides/skins/structure/)
  - ⚠️ 创建文件结构时必须参考
  - ⚠️ 理解皮肤文件组织方式时必须参考

- [布局](https://ihsiao.com/apps/hamster/v3/docs/guides/skins/layout/)
  - ⚠️ 设计键盘布局时必须参考
  - ⚠️ 实现 VStack、HStack 时必须参考

- [样式](https://ihsiao.com/apps/hamster/v3/docs/guides/skins/styles/)
  - ⚠️ 创建样式时必须参考
  - ⚠️ 配置 geometry、systemImage、text 等样式类型时必须参考

- [动作](https://ihsiao.com/apps/hamster/v3/docs/guides/skins/action/)
  - ⚠️ 配置按键动作时必须参考
  - ⚠️ 实现 character、symbol、shortcut 等动作时必须参考

- [动画](https://ihsiao.com/apps/hamster/v3/docs/guides/skins/animation/)
  - ⚠️ 配置按键动画时必须参考
  - ⚠️ 实现 scale、cartoon、physics 动画时必须参考

- [通知](https://ihsiao.com/apps/hamster/v3/docs/guides/skins/notifications/)
  - ⚠️ 实现动态样式变化时必须参考
  - ⚠️ 配置 rime、keyboardAction、returnKeyType 通知时必须参考

- [集合](https://ihsiao.com/apps/hamster/v3/docs/guides/skins/collection/)
  - ⚠️ 创建符号列表时必须参考
  - ⚠️ 实现分类符号、候选字栏时必须参考

- [预编辑区](https://ihsiao.com/apps/hamster/v3/docs/guides/skins/preedit/)
  - ⚠️ 配置预编辑区高度和样式时必须参考

- [配置参数](https://ihsiao.com/apps/hamster/v3/docs/guides/skins/parameters/)
  - ⚠️ 查询参数类型和含义时必须参考
  - ⚠️ 理解 ConditionStyle、notificationType 等高级参数时必须参考

### SF Symbols

- **SF Symbols App**（在 Mac App Store 下载）
  - ⚠️ 查找图标名称时必须使用
  - ⚠️ 验证图标版本兼容性时必须使用

- [SF Symbols 官方文档](https://developer.apple.com/sf-symbols/)
  - 了解图标使用规范和最佳实践

### Jsonnet

- [Jsonnet 官方文档](https://jsonnet.org/learning/tutorial.html)
  - 学习 Jsonnet 基础语法和特性

- [Jsonnet 标准库](https://jsonnet.org/learning/stdlib.html)
  - 查询可用的标准函数

### 软件工程最佳实践

- [Clean Code](https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882)
  - 代码质量标准

- [Design Patterns](https://refactoring.guru/design-patterns)
  - 设计模式参考

- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)
  - 面向对象设计原则

---

## 📞 注意事项

1. **不要修改旧架构**：所有工作在 `v2/` 目录进行，保持旧架构完整作为参考
2. **保持输出一致**：新旧架构生成的 YAML 必须完全相同
3. **逐步迁移**：每个阶段完成后进行测试，不要一次性迁移所有内容
4. **详细注释**：所有配置都要添加注释，说明用途
5. **命名规范**：严格遵循命名规范，保持一致性
6. **版本控制**：每个阶段完成后提交代码，便于回滚
7. **性能优先**：优化性能，避免不必要的计算
8. **测试先行**：编写测试用例，确保质量
9. **文档同步**：代码和文档同步更新
10. **团队协作**：遵循团队规范，保持代码风格一致
11. **⚠️ 不要混淆**：元输入法 ≠ 仓输入法（Hamster），两者是不同的应用，配置方式可能不同
12. **⚠️ 参考官方文档**：遇到问题时必须查阅元输入法官方文档，不要想当然

---

## 🔄 版本历史

| 版本 | 日期 | 说明 |
|------|------|------|
| 1.0 | 2026-02-13 | 初始版本，完整任务清单 |

---

**创建时间**：2026-02-13
**最后更新**：2026-02-13
**状态**：准备阶段
**负责人**：iPure·Pro Team