
# ustcmb --- 数学类报告模板

[![License](https://img.shields.io/badge/License-LPPL%20v1.3c-blue.svg)](http://www.latex-project.org/lppl.txt)
[![Version](https://img.shields.io/badge/Version-v2.2.4-green.svg)](https://github.com/vanabel/mathbeamer)
[![LaTeX](https://img.shields.io/badge/LaTeX-Beamer-orange.svg)](https://www.ctan.org/pkg/beamer)

> 基于USTC学校主题定制的数学报告模板，支持中英文双语，提供良好的打印模式

## 📖 简介

`ustcmb` (ustcmethbeamer) 是基于USTC学校主题定制的报告模板，利用它可以非常方便地制作数学类幻灯片。它同时支持中文与英文的处理，以及良好的打印模式。

### ✨ 主要特性

- 🎨 基于USTC学校主题的现代化设计
- 🌏 完整的中英文双语支持
- 📚 灵活的参考文献处理（支持amsrefs和biblatex）
- 🔄 amsrefs语法兼容层（在biblatex模式下支持`\cite{xxx}*{yyy}`语法）
- 🎯 丰富的定理环境配置选项
- 🖨️ 优化的打印模式支持
- 📱 响应式布局设计

## 🚀 快速开始

### 下载安装

1. 下载模板压缩包：[ustcmb-v2.2.3.zip](https://github.com/vanabel/mathbeamer/blob/main/ustcmb-v2.2.3.zip)
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

### [v2.2.4]

- ✨ 新增 `biblatex` 选项，支持现代参考文献处理
- ✨ 新增多种引用样式选项
- 🔄 保持对传统 `amsrefs` 的向后兼容性
- 🔄 新增amsrefs语法兼容层，在biblatex模式下支持`\cite{xxx}*{yyy}`语法
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

### [v 1.1.1]

1. add more example slides, which includes
 * auto pause in lists
 * two columns in a frame
 * include figure/subfigures in a frame
 * table
 * definition/example/theorem like environments
 * custom defn/examp/thm theorem like environments
 * hyperlinks between slides
2. add thanks before the references
3. user defined commands/environments should be written in `slides/usrdefn.tex`

#### [v 1.1.0]

1. new branch, add three color style:
 * `dark`: dark color style
 * `light`: light color style
 * the default is betwen the above two

#### [v 1.0.1]

1. add link to `slides/bib.bib`, so that you can open it in `WinEdt` by `Build Tree`
2. set the default font theme for math be `\usefonttheme{professionalfonts}`, which makes math formula looks more perfect
3. add `\newcommand{}{}` example and `\newtheorem{}{}` example

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



