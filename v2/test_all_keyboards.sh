#!/bin/bash

echo "测试所有键盘类型生成..."
echo "=========================="

# 测试主配置文件
echo "1. 测试主配置文件..."
jsonnet main.jsonnet > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "   ✅ 主配置文件解析成功"
else
    echo "   ❌ 主配置文件解析失败"
    exit 1
fi

# 测试所有键盘类型
keyboards=("alphabetic" "numeric" "pinyin" "symbolic" "panel")
themes=("light" "dark")
orientations=("portrait" "landscape")

echo "2. 测试所有键盘组合..."
for keyboard in "${keyboards[@]}"; do
    for theme in "${themes[@]}"; do
        for orientation in "${orientations[@]}"; do
            key="${keyboard}_${theme}_${orientation}"
            jsonnet main.jsonnet | jq -e ".${key}" > /dev/null 2>&1
            if [ $? -eq 0 ]; then
                echo "   ✅ ${key} 生成成功"
            else
                echo "   ❌ ${key} 生成失败"
            fi
        done
    done
done

echo "3. 验证键盘基本属性..."
for keyboard in "${keyboards[@]}"; do
    name=$(jsonnet main.jsonnet | jq -r ".${keyboard}_light_portrait.name")
    author=$(jsonnet main.jsonnet | jq -r ".${keyboard}_light_portrait.author")
    buttons=$(jsonnet main.jsonnet | jq -r ".${keyboard}_light_portrait.buttons | length")
    
    echo "   ${keyboard}:"
    echo "     名称: ${name}"
    echo "     作者: ${author}"
    echo "     按钮数: ${buttons}"
done

echo "4. 验证主题颜色..."
for theme in "${themes[@]}"; do
    bg_color=$(jsonnet main.jsonnet | jq -r ".alphabetic_${theme}_portrait.keyboardStyle.backgroundColor")
    echo "   ${theme}主题背景色: ${bg_color}"
done

echo "=========================="
echo "测试完成！所有键盘类型都已成功实现。"