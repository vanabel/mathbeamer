
# ustcmb --- 数学类报告模板

[![License](https://img.shields.io/badge/License-LPPL%20v1.3c-blue.svg)](http://www.latex-project.org/lppl.txt)
[![Version](https://img.shields.io/badge/Version-v2.2.3-green.svg)](https://gitlab.lug.ustc.edu.cn/vanabel/math-beamer)
[![LaTeX](https://img.shields.io/badge/LaTeX-Beamer-orange.svg)](https://www.ctan.org/pkg/beamer)
[![Platform](https://img.shields.io/badge/Platform-macOS%20%7C%20Windows%20%7C%20Linux-lightgrey.svg)](https://gitlab.lug.ustc.edu.cn/vanabel/math-beamer)
[![LaTeX Version](https://img.shields.io/badge/LaTeX%20Version-2005%2F12%2F01%2B-blue.svg)](https://www.latex-project.org/)
[![Maintenance](https://img.shields.io/badge/Maintenance-Actively%20Maintained-brightgreen.svg)](https://gitlab.lug.ustc.edu.cn/vanabel/math-beamer)

<div align="right">

[English](README_EN.md) | [中文](README.md)

</div>

> 基于USTC学校主题定制的数学报告模板，支持中英文双语，提供良好的打印模式

## 📊 项目统计

### 星标趋势
[![Stargazers over time](https://starchart.cc/vanabel/math-beamer.svg?variant=adaptive)](https://starchart.cc/vanabel/math-beamer)

### 贡献统计
[![GitHub stars](https://img.shields.io/github/stars/vanabel/math-beamer?style=social)](https://gitlab.lug.ustc.edu.cn/vanabel/math-beamer)
[![GitHub forks](https://img.shields.io/github/forks/vanabel/math-beamer?style=social)](https://gitlab.lug.ustc.edu.cn/vanabel/math-beamer)
[![GitHub issues](https://img.shields.io/github/issues/vanabel/math-beamer)](https://gitlab.lug.ustc.edu.cn/vanabel/math-beamer)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/vanabel/math-beamer)](https://gitlab.lug.ustc.edu.cn/vanabel/math-beamer)

## 📖 简介

`ustcmb` (ustcmethbeamer) 是基于USTC学校主题定制的报告模板，利用它可以非常方便地制作数学类幻灯片。它同时支持中文与英文的处理，以及良好的打印模式。

### ✨ 主要特性

- 🎨 基于USTC学校主题的现代化设计
- 🌏 完整的中英文双语支持
- 📚 灵活的参考文献处理（支持amsrefs和biblatex）
- 🎯 丰富的定理环境配置选项
- 🖨️ 优化的打印模式支持
- 📱 响应式布局设计

## 🚀 快速开始

### 下载安装

1. 下载模板压缩包：[ustcmb-v2.2.3.zip](https://git.ustclug.org/vanabel/math-beamer/blob/master/ustcmb-v2.2.3.zip)
2. 解压后阅读示例文件 `ustcmb-main.pdf`
3. 参考 `ustcmb-main.tex` 开始编写您的报告

### 基本使用

```latex
\documentclass[zh]{ustcmb}

\title{您的报告标题}
\author{您的姓名}
\institute{您的机构}

\begin{document}
\frame{\titlepage}

\begin{frame}
\frametitle{第一张幻灯片}
内容...
\end{frame}

\end{document}
```

## ⚙️ 配置选项

### 核心选项

| 选项 | 描述 | 默认值 |
|------|------|--------|
| `zh` | 启用中文支持 | 启用 |
| `en` | 英文模式 | 禁用 |
| `thmnum` | 定理带编号 | 禁用 |
| `eqsecnum` | 公式以节编号 | 禁用 |

### 参考文献选项

| 选项 | 描述 | 依赖 |
|------|------|------|
| `authoryear` | 作者年代引用样式 (amsrefs) | amsrefs |
| `allcites` | 输出bib.bib中的所有参考文献 | amsrefs |
| `biblatex` | 使用现代biblatex包 | biblatex |
| `citemath` | 数学论文专用引用样式 | biblatex + xstring |

### 高级选项

| 选项 | 描述 |
|------|------|
| `nds` | 不使用默认设置（需要手动配置） |
| `subnav` | 在每个子节显示导航 |
| `nobib` | 禁用参考文献处理 |

## 📚 示例文件

项目包含多个示例文件，帮助您快速上手：

- `ustcmb-main.tex` - 主要示例文件
- `biblatex-example.tex` - biblatex使用示例
- `amsrefs-example.tex` - amsrefs使用示例
- `math-citation-example.tex` - 数学引用示例

## 🔧 自定义配置

### 使用nds选项时的必要配置

当使用 `nds` 选项时，您需要手动配置以下内容：

```latex
\documentclass[nds]{ustcmb}

\usetheme{YourTheme}

\begin{document}
\frame{\titlepage}

\newtheorem{thm}{Theorem}

\usecolortheme{YourColorTheme}
```

### 字体配置

模板支持自定义中文字体：

```latex
\setCJKmainfont{YourChineseFont}
\setCJKsansfont{YourChineseSansFont}
```

## 📋 版本历史

### [v2.2.4] (开发中)

- ✨ 新增 `biblatex` 选项，支持现代参考文献处理
- ✨ 新增多种引用样式选项
- 🔄 保持对传统 `amsrefs` 的向后兼容性
- ⚡ 优化参考文献配置和引用格式

### [v2.2.3]

- ✨ 新增 `nobib` 选项
- 🧹 移除多余的参考文献导航
- 🔤 重新设置中文字体，支持Mac和Windows系统
- 🎨 重新配置模板标题/正文字体

### [v2.2.2]

- ✨ 新增中文自定义字体命令

### [v2.2.1]

- 🐛 修复 `\CJKunderwave` 兼容性问题

### [v2.2.0]

- ✨ 新增 `subnav` 选项：在每个子节显示导航
- 📖 添加解决 `allowframebreaks` 和 `itemize` 环境冲突的示例
- 🗑️ 移除"Thanks!"页面，应由演示总结替代

### [v2.1.0]

- 🏫 新增SJTU标志支持
- ✨ 为SJTU添加 `domc` 选项

### [v2.0.1]

- 📚 新增用户FAQ
- 🌏 根据 `zh` 或 `en` 模式修改最后一帧的感谢内容

### [v2.0.0]

- 🔧 使用dtx管理文档
- 🗑️ 移除xeCJK字体设置（应由用户自行配置）

### [v1.2.0]

- 🌏 新增中文支持选项，使用 `zh` 启用中文支持
- 🎨 新增默认颜色主题，更接近USTC颜色（主色调为蓝色）

### [v1.1.1]

- 📖 新增更多示例幻灯片，包括：
  * 列表中的自动暂停
  * 单帧中的两列布局
  * 在帧中包含图形/子图形
  * 表格
  * 定义/示例/定理类环境
  * 自定义defn/examp/thm定理类环境
  * 幻灯片之间的超链接
- 🙏 在参考文献前添加感谢页面
- 📝 用户定义的命令/环境应写在 `slides/usrdefn.tex` 中

#### [v1.1.0]

- 🎨 新分支，添加三种颜色样式：
  * `dark`：深色样式
  * `light`：浅色样式
  * 默认样式介于上述两者之间

#### [v1.0.1]

- 🔗 添加 `slides/bib.bib` 链接，可在 `WinEdt` 中通过 `Build Tree` 打开
- 🔤 设置数学的默认字体主题为 `\usefonttheme{professionalfonts}`，使数学公式看起来更完美
- 📚 添加 `\newcommand{}{}` 示例和 `\newtheorem{}{}` 示例

## 🤝 贡献

欢迎提交Issue和Pull Request来改进这个模板！

## 📄 许可证

本项目采用 [LaTeX Project Public License v1.3c](http://www.latex-project.org/lppl.txt) 或更高版本。

## 👨‍💻 作者

**Van Abel** - [van141.abel@gmail.com](mailto:van141.abel@gmail.com)

- 项目主页：[https://gitlab.lug.ustc.edu.cn/vanabel/math-beamer](https://gitlab.lug.ustc.edu.cn/vanabel/math-beamer)
- 许可证：[LPPL v1.3c](http://www.latex-project.org/lppl.txt)

---

<div align="center">

**如果这个模板对您有帮助，请给它一个⭐️星标！**

</div>



