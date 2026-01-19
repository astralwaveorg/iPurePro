#!/bin/bash

# 设置错误时退出
set -e

# 定义变量
PROJECT_DIR="/Users/athena/GitHubRepos/iPurePro"
ZIP_FILE="$PROJECT_DIR/iPure·Pro.zip"
CSKIN_FILE="$PROJECT_DIR/iPure·Pro.cskin"
DEST_FILE="/Users/athena/Library/Mobile Documents/com~apple~CloudDocs/SKINS/iPure·Pro.cskin"

echo "开始构建 iPure·Pro 皮肤包..."

# 1. 运行 Jsonnet 编译命令
echo "运行 Jsonnet 编译..."
cd "$PROJECT_DIR"
jsonnet -S -m . jsonnet/main.jsonnet

# 2. 清理之前的构建文件
echo "清理之前的构建文件..."
rm -f "$ZIP_FILE" "$CSKIN_FILE"

# 3. 打包成 zip 文件，排除指定的文件和目录
echo "打包成 zip 文件..."
zip -r "$ZIP_FILE" "." \
    -x ".git/*" \
    -x ".gitignore" \
    -x "README.md" \
    -x "IFLOW.md" \
    -x "build_skin.sh" \
    -x "*.DS_Store" \
    -x "zi0BThjx"

# 4. 重命名为 .cskin 文件
echo "重命名为 .cskin 文件..."
mv "$ZIP_FILE" "$CSKIN_FILE"

# 5. 强制覆盖目标文件
echo "复制到目标位置..."
cp -f "$CSKIN_FILE" "$DEST_FILE"

# 6. 清理临时文件
echo "清理临时文件..."
rm -f "$CSKIN_FILE"

echo "构建完成！"
echo "皮肤包已保存到: $DEST_FILE"