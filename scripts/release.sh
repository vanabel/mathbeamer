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

# 清理工作目录
echo "🧹 清理工作目录..."
make distclean 2>/dev/null || true
rm -f ustcmb-*.zip 2>/dev/null || true

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
sed "s/VER= v[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*/VER= $VERSION/" Makefile > Makefile.bak
mv Makefile.bak Makefile

# 更新DTX文件中的版本号
echo "  - 更新DTX文件中的版本号..."
# 更新\ProvidesClass行中的版本号
sed "s/\\ProvidesClass{ustcmb}\\[.*v[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*/\\ProvidesClass{ustcmb}[2025\/08\/21 $VERSION/g" ustcmb.dtx > ustcmb.dtx.bak
mv ustcmb.dtx.bak ustcmb.dtx



# 更新README.md中的版本号
echo "  - 更新README.md中的版本号..."
# 更新版本徽章
sed "s/Version-v[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*/Version-$VERSION_NUM/g" README.md > README.md.bak
mv README.md.bak README.md

# 更新README_EN.md中的版本号
echo "  - 更新README_EN.md中的版本号..."
# 更新版本徽章
sed "s/Version-v[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*/Version-$VERSION_NUM/g" README_EN.md > README_EN.md.bak
mv README_EN.md.bak README_EN.md

# 更新README.md中的下载链接
echo "  - 更新README.md中的下载链接..."
# 更新下载链接
sed "s/ustcmb-v[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.zip/ustcmb-$VERSION.zip/g" README.md > README.md.bak
mv README.md.bak README.md

# 更新README_EN.md中的下载链接
echo "  - 更新README_EN.md中的下载链接..."
# 更新下载链接
sed "s/ustcmb-v[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.zip/ustcmb-$VERSION.zip/g" README_EN.md > README_EN.md.bak
mv README_EN.md.bak README_EN.md

# 更新DTX文件中的下载链接
echo "  - 更新DTX文件中的下载链接..."
# 更新下载链接
sed "s/ustcmb-v[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.zip/ustcmb-$VERSION.zip/g" ustcmb.dtx > ustcmb.dtx.bak
mv ustcmb.dtx.bak ustcmb.dtx

# 移除README.md中的changelog部分
echo "  - 移除README.md中的changelog部分..."
# 删除从版本历史开始到文件末尾的所有内容
sed "/## 📋 版本历史/,\$d" README.md > README.md.bak
echo "" >> README.md.bak
echo "## 📋 版本历史" >> README.md.bak
echo "" >> README.md.bak
echo "### [$VERSION]" >> README.md.bak
echo "" >> README.md.bak
echo "- ✨ 新增功能和改进" >> README.md.bak
echo "- 🐛 修复已知问题" >> README.md.bak
echo "- 📚 更新文档" >> README.md.bak
echo "" >> README.md.bak
echo "详细更改请查看 [GitHub提交历史](https://github.com/vanabel/mathbeamer/commits/main)" >> README.md.bak
mv README.md.bak README.md

# 移除README_EN.md中的changelog部分
echo "  - 移除README_EN.md中的changelog部分..."
# 删除从版本历史开始到文件末尾的所有内容，完全移除版本历史部分
sed "/## 📋 Version History/,\$d" README_EN.md > README_EN.md.bak
mv README_EN.md.bak README_EN.md

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

# 发布成功后清理工作目录
echo ""
echo "🧹 发布成功后清理工作目录..."
make distclean 2>/dev/null || true
echo "工作目录清理完成！"
