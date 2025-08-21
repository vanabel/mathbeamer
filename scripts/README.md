# Scripts 目录说明

本目录包含ustcmb项目的各种脚本和说明文档。

## 📁 文件说明

### 脚本文件
- **`release.sh`** - 自动发布脚本，用于创建新版本并触发GitHub Action
  - 自动更新版本号（Makefile + ustcmb.dtx）
  - 确保版本一致性
- **`dev.sh`** - 开发辅助脚本，提供构建、测试、打包等功能
  - 包含版本一致性检查功能

### 说明文档
- **`RELEASE.md`** - 发布流程说明文档

## 🚀 使用方法

### 发布新版本
```bash
# 使用发布脚本（推荐）
./scripts/release.sh v2.2.4

# 脚本会自动：
# 1. 更新Makefile中的版本号
# 2. 更新ustcmb.dtx文件中的版本号（确保版本一致性）
# 3. 构建完整的发布包（make zip）
# 4. 提交发布包到仓库
# 5. 创建并推送标签
# 6. 触发GitHub Action自动发布
```

### 开发辅助
```bash
# 查看所有可用命令
./scripts/dev.sh help

# 构建项目
./scripts/dev.sh build

# 运行测试
./scripts/dev.sh test

# 创建发布包
./scripts/dev.sh package

# 清理项目
./scripts/dev.sh clean

# 检查版本一致性
./scripts/dev.sh check

# 重要：发布前务必检查版本一致性！
```

## 🔧 开发流程

1. **开发阶段**: 修改 `ustcmb.dtx` 等源文件
2. **测试阶段**: 使用 `make` 或 `./scripts/dev.sh test` 测试
3. **版本检查**: 使用 `./scripts/dev.sh check` 确保版本一致性
4. **发布阶段**: 使用 `./scripts/release.sh` 发布新版本
5. **自动发布**: GitHub Action自动将zip文件发布到Releases

## 📋 注意事项

- 所有脚本都需要在项目根目录下运行
- 发布前请确保所有更改已测试通过
- 版本号必须遵循语义化版本规范（如 `v2.2.4`）
- 发布包会在本地构建，GitHub Action只负责发布
- **版本一致性**: 脚本会自动维护版本一致性，无需手动更新多个文件
