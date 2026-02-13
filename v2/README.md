# iPurePro v2 - 平铺结构键盘项目

这是一个为Hamster输入法（元输入法）设计的键盘皮肤项目，采用平铺结构设计，简单直观，易于维护。

## 项目结构

```
v2/
├── keyboards/          # 键盘定义
│   ├── alphabetic_26.jsonnet  # 字母键盘（26键）
│   ├── numeric_9.jsonnet      # 数字键盘（9键）
│   ├── pinyin_26.jsonnet      # 拼音键盘（26键）
│   └── symbolic.jsonnet       # 符号键盘
├── config/             # 配置
│   ├── theme.jsonnet          # 主题颜色（亮色/暗色）
│   └── dimensions.jsonnet     # 尺寸参数（竖屏/横屏）
├── tools/              # 工具函数
│   ├── button.jsonnet         # 按键创建工具
│   └── styles.jsonnet         # 样式生成器
├── main.jsonnet        # 主入口文件
└── test_all_keyboards.sh     # 测试脚本
```

## 键盘类型

### 1. 字母键盘 (alphabetic_26.jsonnet)
- 26个字母键
- 标准QWERTY布局
- 支持大小写切换
- 包含常用功能键（Shift、Backspace、空格、回车等）

### 2. 数字键盘 (numeric_9.jsonnet)
- 9个数字键（1-9）
- 0键和功能键
- 支持小数点、删除等操作
- 简洁的3×3布局

### 3. 拼音键盘 (pinyin_26.jsonnet)
- 基于字母键盘
- 添加拼音输入特有功能
- 支持候选词切换（←/→）
- 中英文切换按钮

### 4. 符号键盘 (symbolic.jsonnet)
- 常用符号集合
- 四行符号布局
- 支持符号翻页
- 快速切换到其他键盘类型

## 主题支持

### 亮色主题 (light)
- 背景：白色 (#FFFFFF)
- 字母键：白色背景，黑色文字
- 功能键：灰色背景，黑色文字
- 回车键：绿色背景

### 暗色主题 (dark)
- 背景：黑色 (#000000)
- 字母键：深灰色背景，白色文字
- 功能键：中灰色背景，白色文字
- 回车键：绿色背景

## 布局支持

### 竖屏布局 (portrait)
- 针对手机竖屏优化
- 按钮尺寸适合手指操作
- 合理的行间距

### 横屏布局 (landscape)
- 针对手机横屏优化
- 按钮尺寸适当调整
- 适应更宽的屏幕空间

## 使用方法

### 1. 生成所有键盘
```bash
jsonnet main.jsonnet > output.json
```

### 2. 生成特定键盘
```bash
# 生成亮色主题竖屏字母键盘
jsonnet main.jsonnet | jq '.alphabetic_light_portrait' > alphabetic_light_portrait.json

# 生成暗色主题横屏拼音键盘
jsonnet main.jsonnet | jq '.pinyin_dark_landscape' > pinyin_dark_landscape.json
```

### 3. 运行测试
```bash
./test_all_keyboards.sh
```

## 扩展和修改

### 添加新键盘
1. 在 `keyboards/` 目录下创建新的 `.jsonnet` 文件
2. 使用现有的工具函数（`button.jsonnet`, `styles.jsonnet`）
3. 在 `main.jsonnet` 中导入并添加到输出

### 修改主题颜色
编辑 `config/theme.jsonnet` 文件：
- 修改 `light` 或 `dark` 主题的颜色值
- 保持颜色格式一致（十六进制）

### 修改尺寸参数
编辑 `config/dimensions.jsonnet` 文件：
- 调整 `portrait` 或 `landscape` 的尺寸值
- 保持百分比格式

## 技术特点

1. **平铺结构**：目录结构简单直观，易于理解和维护
2. **模块化设计**：配置、工具、键盘分离，便于复用
3. **无注释代码**：所有jsonnet文件都没有注释，避免解析问题
4. **自动化测试**：提供测试脚本验证所有键盘组合
5. **主题和布局支持**：支持亮色/暗色主题和竖屏/横屏布局

## 依赖

- `jsonnet`：用于处理Jsonnet文件
- `jq`：用于处理JSON输出（测试脚本需要）

## 作者

- **作者**：sicen
- **项目名称**：iPure·Pro
- **版本**：2.0