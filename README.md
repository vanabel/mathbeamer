
# ustcmb --- 数学类报告模板

[![License](https://img.shields.io/badge/License-LPPL%20v1.3c-blue.svg)](http://www.latex-project.org/lppl.txt)
[![Version](https://img.shields.io/badge/Version-v2.2.8-green.svg)](https://github.com/vanabel/mathbeamer)
[![LaTeX](https://img.shields.io/badge/LaTeX-Beamer-orange.svg)](https://www.ctan.org/pkg/beamer)
[![Platform](https://img.shields.io/badge/Platform-macOS%20%7C%20Windows%20%7C%20Linux-lightgrey.svg)](https://github.com/vanabel/mathbeamer)
[![LaTeX Version](https://img.shields.io/badge/LaTeX%20Version-2005%2F12%2F01%2B-blue.svg)](https://www.latex-project.org/)
[![Maintenance](https://img.shields.io/badge/Maintenance-持续维护-brightgreen.svg)](https://github.com/vanabel/mathbeamer)

<div align="right">

[English](README_EN.md) | [中文](README.md)

</div>

> 基于USTC学校主题定制的数学报告模板，支持中英文双语，提供良好的打印模式

## 📊 项目统计

### Stargazers 趋势
[![Stargazers over time](https://starchart.cc/vanabel/mathbeamer.svg?variant=adaptive)](https://starchart.cc/vanabel/mathbeamer)

### 仓库贡献统计
[![GitHub stars](https://img.shields.io/github/stars/vanabel/mathbeamer?style=social)](https://github.com/vanabel/mathbeamer)
[![GitHub forks](https://img.shields.io/github/forks/vanabel/mathbeamer?style=social)](https://github.com/vanabel/mathbeamer)
[![GitHub issues](https://img.shields.io/github/issues/vanabel/mathbeamer)](https://github.com/vanabel/mathbeamer)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/vanabel/mathbeamer)](https://github.com/vanabel/mathbeamer)

## 📖 简介

`ustcmb` (ustcmethbeamer) 是基于USTC学校主题定制的报告模板，利用它可以非常方便地制作数学类幻灯片。它同时支持中文与英文的处理，以及良好的打印模式。

### ✨ 主要特性

- 🎨 基于USTC学校主题的现代化设计
- 🌏 完整的中英文双语支持
- 📚 灵活的参考文献处理（支持amsrefs和biblatex）
- 🔄 amsrefs 语法兼容层（在 biblatex 模式下支持 `\cite{xxx}*{yyy}` 语法）
- ✅ 迁移至 ctex 包实现自动中文字体处理
- 🎯 丰富的定理环境配置选项
- 🖨️ 优化的打印模式支持
- 📱 响应式布局设计

## 🚀 快速开始

### 下载安装

1. 下载模板压缩包：[ustcmb-v2.2.8.zip](https://github.com/vanabel/mathbeamer/releases/latest)
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
````

## ⚙️ 配置选项

### 核心选项

| 选项         | 描述     | 默认值 |
| ---------- | ------ | --- |
| `zh`       | 启用中文支持 | 启用  |
| `en`       | 英文模式   | 禁用  |
| `thmnum`   | 定理带编号  | 禁用  |
| `eqsecnum` | 公式以节编号 | 禁用  |

### 参考文献选项

| 选项           | 描述                  | 依赖                 |
| ------------ | ------------------- | ------------------ |
| `authoryear` | 作者年代引用样式 (amsrefs)  | amsrefs            |
| `allcites`   | 输出 bib.bib 中的所有参考文献 | amsrefs            |
| `biblatex`   | 使用现代 biblatex 包     | biblatex           |
| `citemath`   | 数学论文专用引用样式          | biblatex + xstring |

### 高级选项

| 选项       | 描述              |
| -------- | --------------- |
| `nds`    | 不使用默认设置（需要手动配置） |
| `subnav` | 在每个子节显示导航       |
| `nobib`  | 禁用参考文献处理        |

## 📚 示例文件

* `ustcmb-main.tex` - 主要示例文件
* `biblatex-example.tex` - biblatex 使用示例
* `amsrefs-example.tex` - amsrefs 使用示例
* `math-citation-example.tex` - 数学引用示例

## 🔧 自定义配置

### 使用 nds 选项时的必要配置

```latex
\documentclass[nds]{ustcmb}

\usetheme{YourTheme}

\begin{document}
\frame{\titlepage}

\newtheorem{thm}{Theorem}

\usecolortheme{YourColorTheme}
```

### 字体配置

```latex
\setCJKmainfont{YourChineseFont}
\setCJKsansfont{YourChineseSansFont}
```

> 💡 **开发者提示**：GitHub Actions 自动发布流程请参考 [`.github/GITHUB_ACTIONS.md`](.github/GITHUB_ACTIONS.md)

## 🤝 贡献

欢迎提交 Issues 和 Pull Requests 来改进此模板！

## 📄 许可证

本项目基于 [LaTeX Project Public License v1.3c](http://www.latex-project.org/lppl.txt) 或更高版本发布。

## 👨‍💻 作者

**Van Abel** - [van141.abel@gmail.com](mailto:van141.abel@gmail.com)

* 项目主页: [https://github.com/vanabel/mathbeamer](https://github.com/vanabel/mathbeamer)
* 许可证: [LPPL v1.3c](http://www.latex-project.org/lppl.txt)

---

<div align="center">

**如果该模板对您有帮助，请给它一个 ⭐️ Star！**

</div>