#!/bin/bash

# 设置错误时退出
set -e

# 定义变量
PROJECT_DIR="/Users/athena/GitHubRepos/iPurePro"
BUILD_DIR="$PROJECT_DIR/iPure·Pro"
ZIP_FILE="$PROJECT_DIR/iPure·Pro.zip"
CSKIN_FILE="$PROJECT_DIR/iPure·Pro.cskin"
DEST_FILE="/Users/athena/Library/Mobile Documents/com~apple~CloudDocs/SKINS/iPure·Pro.cskin"

echo "开始构建 iPure·Pro 皮肤包..."

# 1. 清理之前的构建文件
echo "清理之前的构建文件..."
rm -rf "$BUILD_DIR" "$ZIP_FILE" "$CSKIN_FILE"

# 2. 创建构建目录
echo "创建构建目录..."
mkdir -p "$BUILD_DIR"

# 3. 复制必要的文件到构建目录
echo "复制文件到构建目录..."

# 复制 config.yaml
cp "$PROJECT_DIR/config.yaml" "$BUILD_DIR/"

# 复制 dark 目录
cp -r "$PROJECT_DIR/dark" "$BUILD_DIR/"

# 复制 light 目录
cp -r "$PROJECT_DIR/light" "$BUILD_DIR/"

# 复制 resources 目录（如果存在）
if [ -d "$PROJECT_DIR/resources" ]; then
    cp -r "$PROJECT_DIR/resources" "$BUILD_DIR/"
fi

# 复制 demo.png（如果存在）
if [ -f "$PROJECT_DIR/demo.png" ]; then
    cp "$PROJECT_DIR/demo.png" "$BUILD_DIR/"
fi

# 排除的文件和目录：
# - Git 相关：.git, .gitignore, .DS_Store
# - 文档：README.md, IFLOW.md
# - 源代码：jsonnet/（只保留生成的文件）
# - 脚本：build_skin.sh

echo "文件复制完成"

# 4. 打包成 zip 文件
echo "打包成 zip 文件..."
cd "$PROJECT_DIR"
zip -r "$ZIP_FILE" "iPure·Pro" -x "*.DS_Store" "*.git*" "README.md" "IFLOW.md" "jsonnet/*" "build_skin.sh"

# 5. 重命名为 .cskin 文件
echo "重命名为 .cskin 文件..."
mv "$ZIP_FILE" "$CSKIN_FILE"

# 6. 强制覆盖目标文件
echo "复制到目标位置..."
cp -f "$CSKIN_FILE" "$DEST_FILE"

# 7. 清理构建目录和临时文件
echo "清理临时文件..."
rm -rf "$BUILD_DIR" "$CSKIN_FILE"

echo "构建完成！"
echo "皮肤包已保存到: $DEST_FILE"