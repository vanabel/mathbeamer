# GitHub Action 自动发布说明

## 概述

本项目配置了GitHub Action工作流，当您推送新的版本标签时，会自动打包LaTeX模板并发布到GitHub Releases。

**注意**: 当前版本跳过LaTeX自动构建，直接打包源文件，用户需要在本地运行 `make` 命令生成PDF文档。

**新功能**: 现在支持自动版本管理，发布脚本会自动更新所有相关文件中的版本号，确保版本一致性。

## 工作流程

### 1. 触发条件
- 当您推送一个以 `v` 开头的标签时（如 `v2.2.4`）
- 工作流会自动在Ubuntu环境中运行

### 2. 执行步骤
1. **检出代码**: 获取最新的代码
2. **检查必要文件**: 验证核心文件是否存在
3. **创建发布包**: 
   - 创建包含所有必要文件的目录结构
   - 打包成zip文件
4. **发布到GitHub**: 自动创建GitHub Release并上传文件

### 3. 发布内容
- `ustcmb-{版本号}.zip` - 完整的模板包（包含源文件）
- 所有必要的LaTeX源文件
- logo和图片资源
- 构建配置文件

## 使用方法

### 发布新版本

1. **使用发布脚本（推荐）**
   ```bash
   # 自动更新版本号并发布
   ./scripts/release.sh v2.2.4
   
   # 脚本会自动：
   # - 更新Makefile中的版本号
   # - 更新ustcmb.dtx文件中的版本号
   # - 构建发布包
   # - 提交更改并推送标签
   # - 触发GitHub Action自动发布
   ```

2. **手动更新版本号（不推荐）**
   ```bash
   # 在Makefile中更新版本号
   VER= v2.2.4
   
   # 同时需要手动更新ustcmb.dtx文件中的版本号
   # 确保版本信息的一致性
   ```

3. **提交更改**
   ```bash
   git add .
   git commit -m "更新到版本 v2.2.4"
   git push origin main
   ```

4. **创建并推送标签**
   ```bash
   git tag v2.2.4
   git push origin v2.2.4
   ```

5. **自动发布**
   - GitHub Action会自动触发
   - 在Actions标签页查看构建进度
   - 完成后会在Releases页面看到新版本

### 查看构建状态

1. 进入GitHub仓库
2. 点击 "Actions" 标签页
3. 查看 "自动发布" 工作流的执行状态

### 查看发布结果

1. 进入GitHub仓库
2. 点击 "Releases" 标签页
3. 查看最新发布的版本和下载链接

## 本地构建说明

发布包下载后，用户需要在本地构建PDF文档：

```bash
# 解压发布包
unzip ustcmb-v2.2.4.zip
cd ustcmb-v2.2.4

# 构建文档
make

# 或者单独构建
make cls    # 构建类文件
make doc    # 构建文档
make main   # 构建示例
```

## 注意事项

- 确保所有必要的LaTeX文件都已提交到仓库
- 版本标签必须遵循语义化版本规范（如 `v2.2.4`）
- 如果发布失败，检查Actions日志中的错误信息
- 发布包会自动包含logo和图片文件
- **用户需要在本地安装LaTeX环境并运行make命令**
- **版本一致性**: 使用发布脚本可自动维护版本一致性，避免手动更新多个文件

## 优势

- **快速发布**: 跳过LaTeX构建，大幅减少构建时间
- **轻量级**: 不需要安装大型LaTeX发行版
- **灵活**: 用户可以在本地根据需要构建文档
- **可靠**: 减少构建环境依赖问题
- **版本管理**: 自动维护版本一致性，减少人为错误

## 故障排除

### 常见问题

1. **文件缺失**
   - 检查工作流中的文件复制步骤
   - 确保源文件存在且可访问

2. **发布失败**
   - 检查GitHub Token权限
   - 查看Actions日志中的详细错误信息

3. **版本不一致**
   - 使用 `./scripts/dev.sh check` 检查版本一致性
   - 确保Makefile和ustcmb.dtx中的版本号一致

4. **本地构建失败**
   - 确保安装了完整的LaTeX环境
   - 检查Makefile配置
   - 查看构建日志

## 自定义配置

您可以根据需要修改 `.github/workflows/release.yml` 文件：

- 更改触发条件
- 添加更多文件检查
- 修改发布包内容
- 调整错误处理逻辑

## 相关链接

- [项目主页](https://github.com/vanabel/mathbeamer)
- [GitHub Actions](https://github.com/vanabel/mathbeamer/actions)
- [Releases](https://github.com/vanabel/mathbeamer/releases)
- [主README文档](../README.md)
