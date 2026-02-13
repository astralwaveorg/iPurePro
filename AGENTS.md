# iPure·Pro 项目指南

## 项目概述

iPure·Pro 是一个基于 Hamster 输入法的现代化皮肤配置项目，使用 Jsonnet 模板语言生成，支持亮色和暗色两种主题。项目采用模块化架构，提供简洁优雅的 UI 设计，支持丰富的滑动和长按功能，完美适配 iPhone 和 iPad 设备。

### 核心技术栈

- **配置语言**: Jsonnet（模板语言）
- **输出格式**: YAML（Hamster 输入法配置）
- **图标系统**: SF Symbols (iOS 15+)
- **支持版本**: Hamster 输入法 v3+

### 项目架构

```
iPurePro/
├── jsonnet/                    # Jsonnet 源文件
│   ├── main.jsonnet           # 主入口文件，生成所有配置
│   ├── keyboard/              # 键盘布局定义
│   │   ├── pinyin_26.jsonnet        # 拼音键盘（26键）
│   │   ├── alphabetic_26.jsonnet    # 字母键盘（26键）
│   │   ├── numeric_9_portrait.jsonnet  # 数字键盘（竖屏）
│   │   ├── numeric_9_landscape.jsonnet # 数字键盘（横屏）
│   │   ├── symbolic_portrait.jsonnet    # 符号键盘
│   │   ├── emoji_portrait.jsonnet       # Emoji 键盘
│   │   └── panel.jsonnet                # 浮动模式面板
│   └── lib/                 # 库文件（共享配置）
│       ├── core/            # 核心库
│       │   ├── constants.libsonnet      # 常量定义（按键尺寸、字体、偏移等）
│       │   ├── theme.libsonnet          # 主题颜色（亮色/暗色）
│       │   ├── buttonSize.libsonnet     # 按键尺寸配置
│       │   ├── layout.libsonnet         # 布局配置
│       │   └── utils.libsonnet          # 工具函数
│       ├── components/     # 组件库
│       │   └── button.libsonnet         # 按键组件
│       ├── styles/         # 样式库
│       │   └── generator.libsonnet      # 样式生成器
│       └── data/           # 数据库
│           ├── swipeData.libsonnet      # 滑动操作数据（中文）
│           ├── swipeData-en.libsonnet   # 滑动操作数据（英文）
│           ├── hintSymbolsData.libsonnet # 提示符号数据
│           └── collectionData.libsonnet  # 集合数据
├── light/                      # 亮色主题生成的配置文件
├── dark/                       # 暗色主题生成的配置文件
└── .github/workflows/          # CI/CD 配置
    └── release.yml             # 自动构建和发布
```

## 构建和运行

### 前置要求

- 安装 Jsonnet 编译器：
  - macOS: `brew install jsonnet`
  - Ubuntu: `sudo apt-get install jsonnet`

### 构建命令

**方式一：使用 Jsonnet 直接编译**

```bash
jsonnet -S -m . jsonnet/main.jsonnet
```

此命令会读取 `jsonnet/main.jsonnet` 作为入口，生成所有键盘配置文件到对应的 `light/` 和 `dark/` 目录。

**方式二：手机端编译**

在 Hamster 输入法中，长按皮肤，选择「运行 main.jsonnet」

### CI/CD 自动构建

项目使用 GitHub Actions 实现自动构建和发布。推送到 `main` 分支时会自动：

1. 安装 Jsonnet
2. 生成版本号（格式：v1.YYYYMMDDHHMM）
3. 编译所有 Jsonnet 文件
4. 打包成 `.cskin` 文件
5. 创建 GitHub Release

详见 `.github/workflows/release.yml`

## 开发约定

### 文件命名规范

- Jsonnet 库文件使用 `.libsonnet` 后缀
- 键盘配置文件使用描述性名称（如 `pinyin_26.jsonnet`）
- 生成的 YAML 文件存放在 `light/` 或 `dark/` 目录

### 代码结构约定

1. **主入口文件** (`main.jsonnet`)：负责导入所有模块并生成最终配置
2. **键盘文件** (`keyboard/*.jsonnet`)：每个文件定义一个键盘类型，导出 `new(theme, orientation)` 函数
3. **库文件** (`lib/*.libsonnet`)：共享的配置和数据，通过 `import` 引用
4. **核心库** (`lib/core/`)：存放常量、主题、工具函数等基础配置

### 模块化设计原则

- **关注点分离**：布局、样式、数据分别存放在不同模块
- **可复用性**：公共配置提取到库文件中
- **主题支持**：通过 `theme` 参数统一管理亮色/暗色切换
- **方向适配**：通过 `orientation` 参数统一管理竖屏/横屏切换

### 常量管理

所有常量定义在 `lib/core/constants.libsonnet` 中：

- `BUTTON`: 按钮尺寸和圆角
- `DIMENSIONS`: 键盘、工具栏、预编辑区高度
- `ANIMATION`: 按钮动画参数
- `LAYOUT`: 布局比例
- `FONT_SIZE`: 各组件字体大小
- `OFFSET`: 位置偏移量
- `LANDSCAPE_BUTTON_WIDTH`: 横屏按键宽度
- `PORTRAIT_BUTTON_WIDTH`: 竖屏按键宽度

### 主题管理

主题定义在 `lib/core/theme.libsonnet` 中，包含：

- `light`: 亮色主题颜色配置
- `dark`: 暗色主题颜色配置
- 颜色分类：
  - `background`: 背景颜色
  - `alphabeticKey`: 字母键颜色
  - `functionKey`: 功能键颜色
  - `enterKey`: 回车键颜色
  - `text`: 文本颜色
  - `candidate`: 候选栏颜色
  - `bubble`: 气泡颜色
  - `toolbar`: 工具栏颜色
  - `longPress`: 长按选中颜色

### 数据管理

- **滑动数据**：`lib/data/swipeData.libsonnet`（中文）和 `swipeData-en.libsonnet`（英文）
- **提示符号**：`lib/data/hintSymbolsData.libsonnet`
- **集合数据**：`lib/data/collectionData.libsonnet`

## 功能特性

### 支持的键盘类型

1. **拼音键盘** (`pinyin_26`)：中文拼音输入，26键布局
2. **字母键盘** (`alphabetic_26`)：英文输入，26键布局
3. **数字键盘** (`numeric_9`)：数字输入，9键布局，支持竖屏和横屏
4. **符号键盘** (`symbolic`)：符号输入，分类展示
5. **面板键盘** (`panel`)：浮动模式键盘

### 滑动功能

通过上下滑动按键可以快速输入符号或执行快捷操作：

- **上滑**：数字、符号、快捷操作（全选、剪切、复制、粘贴等）
- **下滑**：特殊符号、快捷操作（撤销、重做、换行等）

滑动数据定义在 `lib/data/swipeData.libsonnet` 中。

### 智能回车

根据输入框类型自动显示不同的回车文字：

- Return（默认）
- Go/前进（网页）
- Search（搜索）
- Send（发送）
- Done（完成）

### 支持的设备

- **iPhone**：竖屏和横屏模式
- **iPad**：竖屏、横屏和浮动模式

## 自定义修改

### 修改常量

编辑 `jsonnet/lib/core/constants.libsonnet`，可以修改：

- 按键尺寸（`BUTTON`）
- 键盘高度（`DIMENSIONS`）
- 字体大小（`FONT_SIZE`）
- 位置偏移（`OFFSET`）
- 按键宽度比例（`LANDSCAPE_BUTTON_WIDTH`, `PORTRAIT_BUTTON_WIDTH`）

### 修改主题

编辑 `jsonnet/lib/core/theme.libsonnet`，可以修改：

- 亮色/暗色主题颜色
- 按键背景和前景颜色
- 功能键样式

### 修改滑动数据

编辑 `jsonnet/lib/data/swipeData.libsonnet` 或 `swipeData-en.libsonnet`，可以修改：

- 上滑操作（`swipeUp`）
- 下滑操作（`swipeDown`）
- 快捷功能映射

### 修改键盘布局

编辑 `jsonnet/keyboard/` 目录下的对应文件，可以修改：

- 按键排列顺序
- 按键尺寸配置
- 特殊按键行为

### 修改样式

编辑 `jsonnet/lib/styles/generator.libsonnet`，可以修改：

- 按键样式生成逻辑
- 背景样式
- 前景样式

## 重要说明

### 简繁切换

RIME 中的简繁切换需要设置为输入方案中的选项配置：
- 默认值（雾淞）：`traditionalization`
- 万象输入法方案：`s2t`

### 图标系统

项目使用 SF Symbols 图标系统，部分常用图标：

- `capslock` / `capslock.fill`：Shift 键
- `return.left`：回车键
- `magnifyingglass`：搜索
- `paperplane`：发送
- `arrowshape.turn.up.forward`：前往
- `checkmark.app.stack`：完成
- `wand.and.outline`：全选
- `scissors`：剪切
- `document.badge.plus`：复制
- `document.on.clipboard`：粘贴
- `list.bullet.clipboard`：剪贴板列表

## 版本历史

使用 `git log --oneline` 查看提交历史。

## 贡献指南

1. Fork 项目
2. 创建特性分支
3. 提交更改
4. 推送到分支
5. 创建 Pull Request

---

*本文档由 iFlow CLI 自动生成*