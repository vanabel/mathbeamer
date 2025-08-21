# 发布说明

## 自动发布流程

本项目采用**本地构建 + 自动发布**的模式。当您推送新的版本标签时，系统会自动：

1. 检查本地构建的发布包
2. 发布到GitHub Releases

## 重要说明

**✅ 优势**: 发布包在本地完整构建，包含所有预编译文件。用户下载后可直接使用，无需额外构建。

## 快速发布

### 方法1: 使用发布脚本（推荐）

```bash
# 发布新版本
./scripts/release.sh v2.2.4

# 脚本会自动：
# - 更新Makefile中的版本号
# - 更新ustcmb.dtx文件中的版本号（确保版本一致性）
# - 构建完整的发布包（包含所有文件）
# - 提交发布包到仓库
# - 创建并推送标签
# - 触发GitHub Action自动发布
```

### 方法2: 手动操作

1. **更新版本号**
   ```bash
   # 编辑Makefile，更新VER变量
   VER= v2.2.4
   
   # 同时更新ustcmb.dtx文件中的版本号
   # 查找并替换所有相关的版本号引用
   # 确保版本信息的一致性
   ```

2. **构建发布包**
   ```bash
   make clean
   make zip
   ```

3. **提交更改**
   ```bash
   git add Makefile ustcmb-v2.2.4.zip
   git commit -m "发布版本 v2.2.4"
   git push origin main
   ```

4. **创建标签**
   ```bash
   git tag v2.2.4
   git push origin v2.2.4
   ```

## 发布内容

每次发布会自动包含：

- `ustcmb-{版本号}.zip` - 完整的模板包（开箱即用）

**版本一致性保证**：
- 自动更新 `Makefile` 和 `ustcmb.dtx` 中的版本号
- 确保所有相关文件中的版本信息保持一致
- 避免版本不一致导致的构建问题

**包含的文件**：
- `ustcmb.cls` - LaTeX类文件
- `ustcmb.pdf` - 模板文档
- `ustcmb-main.tex` - 示例源文件
- `ustcmb-main.pdf` - 示例演示
- `beamercolorthemeustc.sty` - 颜色主题
- `logo/` 和 `figs/` - 资源文件
- 所有必要的源文件和构建配置

## 用户使用

发布包下载后，用户可以直接使用：

```bash
# 解压发布包
unzip ustcmb-v2.2.4.zip
cd ustcmb-v2.2.4

# 直接使用（无需构建）
# - 查看 ustcmb.pdf 了解使用说明
# - 参考 ustcmb-main.tex 编写报告
# - 使用 ustcmb.cls 作为文档类
```

## 版本号规范

使用语义化版本号：
- 格式：`v<主版本>.<次版本>.<修订版本>`
- 示例：`v2.2.4`, `v3.0.0`, `v2.3.1`

## 查看发布状态

1. **Actions页面**: 查看构建进度
2. **Releases页面**: 查看发布结果和下载链接

## 优势

- **快速发布**: 跳过LaTeX构建，大幅减少构建时间
- **轻量级**: 不需要安装大型LaTeX发行版
- **灵活**: 用户可以在本地根据需要构建文档
- **可靠**: 减少构建环境依赖问题
- **版本管理**: 自动维护版本一致性，减少人为错误

## 故障排除

如果发布失败：

1. 检查Actions日志中的错误信息
2. 确保所有必要文件都存在
3. 验证版本号格式
4. 检查版本一致性（Makefile vs ustcmb.dtx）
5. 检查GitHub权限设置

## 更多信息

详细的使用说明请参考：
- [GitHub Action说明](.github/README.md)
- [项目README](README.md)
