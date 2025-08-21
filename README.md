
# ustcmb --- 数学类报告模板

[![License](https://img.shields.io/badge/License-LPPL%20v1.3c-blue.svg)](http://www.latex-project.org/lppl.txt)
[![Version](https://img.shields.io/badge/Version-v2.2.6-green.svg)](https://github.com/vanabel/mathbeamer)
[![LaTeX](https://img.shields.io/badge/LaTeX-Beamer-orange.svg)](https://www.ctan.org/pkg/beamer)

> 基于USTC学校主题定制的数学报告模板，支持中英文双语，提供良好的打印模式

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

1. 下载模板压缩包：[最新版本](https://github.com/vanabel/mathbeamer/releases/latest)
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

### [$VERSION]

- ✨ 新增功能和改进
- 🐛 修复已知问题
- 📚 更新文档

详细更改请查看 [GitHub提交历史](https://github.com/vanabel/mathbeamer/commits/main)

### Copyright and Licence

Copyright (C) 2016 by Van Abel <van141.abel@gmail.com>

This work may be distributed and/or modified under the
conditions of the LaTeX Project Public License, either version 1.3
of this license or (at your option) any later version.
The latest version of this license is in

http://www.latex-project.org/lppl.txt

and version 1.3 or later is part of all distributions of LaTeX
version 2005/12/01 or later.

    This work consists of the file: ustcmb.dtx
             and the derived files: ustcmb.ins
                                    ustcmb.cls
                                    ustcmb.tex
                                    ustcmb.cfg
                                    beamercolorthemeustc.sty
                                    READEME.md (this file)



