# ustcmb --- Mathematical Report Template

[![License](https://img.shields.io/badge/License-LPPL%20v1.3c-blue.svg)](http://www.latex-project.org/lppl.txt)
[![Version](https://img.shields.io/badge/Version-v2.2.3-green.svg)](https://github.com/vanabel/mathbeamer)
[![LaTeX](https://img.shields.io/badge/LaTeX-Beamer-orange.svg)](https://www.ctan.org/pkg/beamer)
[![Platform](https://img.shields.io/badge/Platform-macOS%20%7C%20Windows%20%7C%20Linux-lightgrey.svg)](https://github.com/vanabel/mathbeamer)
[![LaTeX Version](https://img.shields.io/badge/LaTeX%20Version-2005%2F12%2F01%2B-blue.svg)](https://www.latex-project.org/)
[![Maintenance](https://img.shields.io/badge/Maintenance-Actively%20Maintained-brightgreen.svg)](https://github.com/vanabel/mathbeamer)

<div align="right">

[English](README_EN.md) | [中文](README.md)

</div>

> Mathematical report template based on USTC school theme, supporting both Chinese and English, with excellent print mode

## 📊 Project Statistics

### Stargazers over time
[![Stargazers over time](https://starchart.cc/vanabel/mathbeamer.svg?variant=adaptive)](https://starchart.cc/vanabel/mathbeamer)

### Contribution Statistics
[![GitHub stars](https://img.shields.io/github/stars/vanabel/mathbeamer?style=social)](https://github.com/vanabel/mathbeamer)
[![GitHub forks](https://img.shields.io/github/forks/vanabel/mathbeamer?style=social)](https://github.com/vanabel/mathbeamer)
[![GitHub issues](https://img.shields.io/github/issues/vanabel/mathbeamer)](https://github.com/vanabel/mathbeamer)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/vanabel/mathbeamer)](https://github.com/vanabel/mathbeamer)

## 📖 Introduction

`ustcmb` (ustcmethbeamer) is a report template customized based on the USTC school theme, which can be used to create mathematical slides very conveniently. It supports both Chinese and English processing, as well as excellent print mode.

### ✨ Key Features

- 🎨 Modern design based on USTC school theme
- 🌏 Complete bilingual support for Chinese and English
- 📚 Flexible bibliography processing (supports amsrefs and biblatex)
- 🎯 Rich theorem environment configuration options
- 🖨️ Optimized print mode support
- 📱 Responsive layout design

## 🚀 Quick Start

### Download and Install

1. Download the template package: [ustcmb-v2.2.3.zip](https://github.com/vanabel/mathbeamer/blob/main/ustcmb-v2.2.3.zip)
2. After extraction, read the example file `ustcmb-main.pdf`
3. Refer to `ustcmb-main.tex` to start writing your report

### Basic Usage

```latex
\documentclass[zh]{ustcmb}

\title{Your Report Title}
\author{Your Name}
\institute{Your Institution}

\begin{document}
\frame{\titlepage}

\begin{frame}
\frametitle{First Slide}
Content...
\end{frame}

\end{document}
```

## ⚙️ Configuration Options

### Core Options

| Option | Description | Default |
|--------|-------------|---------|
| `zh` | Enable Chinese support | Enabled |
| `en` | English mode | Disabled |
| `thmnum` | Numbered theorems | Disabled |
| `eqsecnum` | Number equations by section | Disabled |

### Bibliography Options

| Option | Description | Dependency |
|--------|-------------|------------|
| `authoryear` | Author-year citation style (amsrefs) | amsrefs |
| `allcites` | Output all references in bib.bib | amsrefs |
| `biblatex` | Use modern biblatex package | biblatex |
| `citemath` | Mathematical paper citation style | biblatex + xstring |

### Advanced Options

| Option | Description |
|--------|-------------|
| `nds` | Do not use default settings (requires manual configuration) |
| `subnav` | Display navigation at each subsection |
| `nobib` | Disable bibliography processing |

## 📚 Example Files

The project contains multiple example files to help you get started quickly:

- `ustcmb-main.tex` - Main example file
- `biblatex-example.tex` - biblatex usage example
- `amsrefs-example.tex` - amsrefs usage example
- `math-citation-example.tex` - Mathematical citation example

## 🔧 Custom Configuration

### Required Configuration When Using nds Option

When using the `nds` option, you need to manually configure the following:

```latex
\documentclass[nds]{ustcmb}

\usetheme{YourTheme}

\begin{document}
\frame{\titlepage}

\newtheorem{thm}{Theorem}

\usecolortheme{YourColorTheme}
```

### Font Configuration

The template supports custom Chinese fonts:

```latex
\setCJKmainfont{YourChineseFont}
\setCJKsansfont{YourChineseSansFont}
```

## 📋 Version History

### [v2.2.4] (In Development)

- ✨ Added `biblatex` option, supporting modern bibliography processing
- ✨ Added multiple citation style options
- 🔄 Maintained backward compatibility with traditional `amsrefs`
- ⚡ Optimized bibliography configuration and citation format

### [v2.2.3]

- ✨ Added `nobib` option
- 🧹 Removed redundant bibliography navigation
- 🔤 Reset Chinese fonts to support both Mac and Windows systems
- 🎨 Reconfigured template title/body fonts

### [v2.2.2]

- ✨ Added Chinese custom font commands

### [v2.2.1]

- 🐛 Fixed `\CJKunderwave` compatibility issue

### [v2.2.0]

- ✨ Added `subnav` option: display navigation at each subsection
- 📖 Added example for resolving conflicts between `allowframebreaks` and `itemize` environment
- 🗑️ Removed "Thanks!" page, should be replaced by presentation summary

### [v2.1.0]

- 🏫 Added SJTU logo support
- ✨ Added `domc` option for SJTU

### [v2.0.1]

- 📚 Added user FAQ
- 🌏 Modified thanks at last frame based on `zh` or `en` mode

### [v2.0.0]

- 🔧 Used dtx to manage documentation
- 🗑️ Removed xeCJK font settings (should be configured by user)

### [v1.2.0]

- 🌏 Added Chinese support option, use `zh` to enable Chinese support
- 🎨 Added default color theme, more like USTC colors (blue as main color)

### [v1.1.1]

1. Added more example slides, including:
   * Auto pause in lists
   * Two columns in a frame
   * Include figure/subfigures in a frame
   * Table
   * Definition/example/theorem-like environments
   * Custom defn/examp/thm theorem-like environments
   * Hyperlinks between slides
2. Added thanks before references
3. User-defined commands/environments should be written in `slides/usrdefn.tex`

#### [v1.1.0]

1. New branch, added three color styles:
   * `dark`: dark color style
   * `light`: light color style
   * The default is between the above two

#### [v1.0.1]

1. Added link to `slides/bib.bib`, so you can open it in `WinEdt` using `Build Tree`
2. Set default font theme for math to `\usefonttheme{professionalfonts}`, making math formulas look more perfect
3. Added `\newcommand{}{}` example and `\newtheorem{}{}` example

## 🤝 Contributing

Welcome to submit Issues and Pull Requests to improve this template!

## 📄 License

This project is licensed under [LaTeX Project Public License v1.3c](http://www.latex-project.org/lppl.txt) or later.

## 👨‍💻 Author

**Van Abel** - [van141.abel@gmail.com](mailto:van141.abel@gmail.com)

- Project Homepage: [https://github.com/vanabel/mathbeamer](https://github.com/vanabel/mathbeamer)
- License: [LPPL v1.3c](http://www.latex-project.org/lppl.txt)

---

<div align="center">

**If this template helps you, please give it a ⭐️ star!**

</div>
