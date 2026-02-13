#!/bin/bash

echo "=== iPurePro v2 项目最终验证 ==="
echo "验证时间: $(date)"
echo ""

# 1. 验证文件结构
echo "1. 验证文件结构..."
expected_files=(
  "config/dimensions.jsonnet"
  "config/theme.jsonnet"
  "keyboards/alphabetic_26.jsonnet"
  "keyboards/numeric_9.jsonnet"
  "keyboards/pinyin_26.jsonnet"
  "keyboards/symbolic.jsonnet"
  "tools/button.jsonnet"
  "tools/styles.jsonnet"
  "main.jsonnet"
  "panel.jsonnet"
  "README.md"
  "PROJECT_SUMMARY.md"
  "test_all_keyboards.sh"
)

all_files_exist=true
for file in "${expected_files[@]}"; do
  if [ -f "$file" ]; then
    echo "   ✅ $file"
  else
    echo "   ❌ $file (缺失)"
    all_files_exist=false
  fi
done

if [ "$all_files_exist" = false ]; then
  echo "错误：缺少必要的文件"
  exit 1
fi

echo ""

# 2. 验证主文件
echo "2. 验证主文件..."
jsonnet main.jsonnet > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "   ✅ main.jsonnet 解析成功"
else
  echo "   ❌ main.jsonnet 解析失败"
  exit 1
fi

# 3. 验证配置数量
echo "3. 验证配置数量..."
keyboard_count=$(jsonnet main.jsonnet | jq 'keys | length - 1')
if [ "$keyboard_count" -eq 20 ]; then
  echo "   ✅ 正确生成20个键盘/面板组合"
else
  echo "   ❌ 期望20个组合，实际生成 $keyboard_count 个"
  exit 1
fi

# 4. 验证所有键盘类型
echo "4. 验证所有键盘类型..."
keyboard_types=("alphabetic" "numeric" "pinyin" "symbolic" "panel")
all_keyboards_valid=true

for type in "${keyboard_types[@]}"; do
  for theme in "light" "dark"; do
    for orientation in "portrait" "landscape"; do
      key="${type}_${theme}_${orientation}"
      jsonnet main.jsonnet | jq -e ".${key}" > /dev/null 2>&1
      if [ $? -ne 0 ]; then
        echo "   ❌ $key 生成失败"
        all_keyboards_valid=false
      fi
    done
  done
done

if [ "$all_keyboards_valid" = true ]; then
  echo "   ✅ 所有20种组合生成成功"
else
  echo "   ❌ 部分组合生成失败"
  exit 1
fi

# 5. 验证主题颜色
echo "5. 验证主题颜色..."
light_bg=$(jsonnet main.jsonnet | jq -r '.alphabetic_light_portrait.keyboardStyle.backgroundColor')
dark_bg=$(jsonnet main.jsonnet | jq -r '.alphabetic_dark_portrait.keyboardStyle.backgroundColor')

if [ "$light_bg" = "#FFFFFF" ] && [ "$dark_bg" = "#000000" ]; then
  echo "   ✅ 主题颜色正确 (亮色: $light_bg, 暗色: $dark_bg)"
else
  echo "   ❌ 主题颜色错误 (亮色: $light_bg, 暗色: $dark_bg)"
  exit 1
fi

# 6. 验证按钮数量
echo "6. 验证按钮数量..."
all_buttons_valid=true

# 使用case语句代替关联数组
for type in "${keyboard_types[@]}"; do
  actual=$(jsonnet main.jsonnet | jq -r ".${type}_light_portrait.buttons | length")
  
  case $type in
    "alphabetic")
      expected=33
      ;;
    "numeric")
      expected=16
      ;;
    "pinyin")
      expected=35
      ;;
    "symbolic")
      expected=46
      ;;
    "panel")
      expected=8
      ;;
    *)
      expected=0
      ;;
  esac
  
  if [ "$actual" -eq "$expected" ]; then
    echo "   ✅ $type: $actual 个按钮 (期望: $expected)"
  else
    echo "   ❌ $type: $actual 个按钮 (期望: $expected)"
    all_buttons_valid=false
  fi
done

if [ "$all_buttons_valid" = false ]; then
  echo "   ❌ 按钮数量验证失败"
  exit 1
fi

echo ""
echo "=== 验证完成 ==="
echo "✅ 所有验证通过"
echo "✅ 项目结构完整"
echo "✅ 代码功能正确"
echo "✅ 文档齐全"
echo ""
echo "iPurePro v2 项目已成功完成！"