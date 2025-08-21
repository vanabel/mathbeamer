#!/bin/bash

# ustcmb 发布脚本
# 使用方法: ./scripts/release.sh <版本号>
# 例如: ./scripts/release.sh v2.2.4

set -e

# 检查参数
if [ $# -eq 0 ]; then
    echo "错误: 请提供版本号"
    echo "使用方法: $0 <版本号>"
    echo "例如: $0 v2.2.4"
    exit 1
fi

VERSION=$1

# 验证版本号格式
if [[ ! $VERSION =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "错误: 版本号格式不正确"
    echo "正确格式: v<主版本>.<次版本>.<修订版本>"
    echo "例如: v2.2.4"
    exit 1
fi

echo "开始发布版本: $VERSION"
echo ""

# 检查是否有未提交的更改
if [ -n "$(git status --porcelain)" ]; then
    echo "警告: 有未提交的更改"
    echo "请先提交所有更改，然后继续"
    exit 1
fi

# 检查是否已经存在该标签
if git tag -l | grep -q "^$VERSION$"; then
    echo "错误: 标签 $VERSION 已经存在"
    exit 1
fi

# 提取版本号部分（去掉v前缀）
VERSION_NUM=$(echo $VERSION | sed 's/^v//')

echo "更新文件中的版本信息..."

# 更新Makefile中的版本号
echo "  - 更新Makefile中的版本号..."
sed -i.bak "s/VER= v[0-9]\+\.[0-9]\+\.[0-9]\+/VER= $VERSION/" Makefile
rm Makefile.bak

# 更新DTX文件中的版本号
echo "  - 更新DTX文件中的版本号..."
sed -i.bak "s/v[0-9]\+\.[0-9]\+\.[0-9]\+/v$VERSION_NUM/g" ustcmb.dtx
rm ustcmb.dtx.bak

# 更新README.md中的版本号
echo "  - 更新README.md中的版本号..."
sed -i.bak "s/Version-v[0-9]\+\.[0-9]\+\.[0-9]\+/Version-$VERSION_NUM/g" README.md
rm README.md.bak

# 更新README_EN.md中的版本号
echo "  - 更新README_EN.md中的版本号..."
sed -i.bak "s/Version-v[0-9]\+\.[0-9]\+\.[0-9]\+/Version-$VERSION_NUM/g" README_EN.md
rm README_EN.md.bak

# 更新README.md中的下载链接
echo "  - 更新README.md中的下载链接..."
sed -i.bak "s/ustcmb-v[0-9]\+\.[0-9]\+\.[0-9]\+\.zip/ustcmb-$VERSION.zip/g" README.md
rm README.md.bak

# 更新README_EN.md中的下载链接
echo "  - 更新README_EN.md中的下载链接..."
sed -i.bak "s/ustcmb-v[0-9]\+\.[0-9]\+\.[0-9]\+\.zip/ustcmb-$VERSION.zip/g" README_EN.md
rm README_EN.md.bak

# 更新DTX文件中的下载链接
echo "  - 更新DTX文件中的下载链接..."
sed -i.bak "s/ustcmb-v[0-9]\+\.[0-9]\+\.[0-9]\+\.zip/ustcmb-$VERSION.zip/g" ustcmb.dtx
rm ustcmb.dtx.bak

# 更新版本历史中的开发中标记
echo "  - 更新版本历史标记..."
sed -i.bak "s/### \[$VERSION\] (开发中)/### [$VERSION]/g" README.md
sed -i.bak "s/### \[$VERSION\] (In Development)/### [$VERSION]/g" README_EN.md
rm README.md.bak README_EN.md.bak 2>/dev/null || true

echo "版本信息更新完成！"
echo ""

# 构建完整的发布包
echo "构建完整的发布包..."
make clean
make zip

# 检查发布包是否创建成功
ZIP_FILE="ustcmb-$VERSION.zip"
if [ ! -f "$ZIP_FILE" ]; then
    echo "错误: 发布包 $ZIP_FILE 创建失败"
    exit 1
fi

echo "发布包创建成功: $ZIP_FILE"

# 提交版本更新和发布包
echo "提交版本更新和发布包..."
git add Makefile ustcmb.dtx README.md README_EN.md "$ZIP_FILE"
git commit -m "发布版本 $VERSION

- 更新所有文件中的版本信息到 $VERSION
- 更新下载链接和徽章
- 构建发布包 $ZIP_FILE"

# 推送更改
echo "推送更改到远程仓库..."
git push origin main

# 创建并推送标签
echo "创建标签 $VERSION..."
git tag $VERSION
git push origin $VERSION

echo ""
echo "发布流程完成！"
echo ""
echo "下一步:"
echo "1. 等待GitHub Action自动发布到Releases"
echo "2. 在Actions标签页查看发布进度"
echo "3. 在Releases页面查看发布结果"
echo ""
echo "重要说明:"
echo "- 发布包已在本地构建完成，包含所有必要文件"
echo "- GitHub Action只负责将zip文件发布到Releases"
echo "- 用户下载后可直接使用，无需额外构建"
echo ""
echo "如果遇到问题，请检查Actions日志中的错误信息"
