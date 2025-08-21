# ustcmb --- 数学类报告模板

### 简介

`ustcmb`(ustcmethbeamer) 是基于USTC学校主题定制的报告模板, 利用它可以非常方便的制作幻灯片. 它同时支持中文与英文的处理, 以及良好的打印模式.

----------------------------------------------------------------
       模板名称: ustcmb
           描述: 中科大数学报告模板
       模板网址: https://gitlab.lug.ustc.edu.cn/vanabel/math-beamer
         版本号: v2.2.3
           作者: Van Abel
         E-mail: van141.abel@gmail.com
        License: LaTeX Project Public License v1.3c or later
    License URI: http://www.latex-project.org/lppl.txt

----------------------------------------------------------------

### 如何使用模板

首先下载该模板的[zip压缩包](https://git.ustclug.org/vanabel/math-beamer/blob/master/ustcmb-v2.2.3.zip), 解压后先阅读下压缩包里面的示例文件`ustcmb-main.pdf`. 然和你可以仿照`ustcmb-main.tex`来写作自己的报告. 更进一步地, 你可以参考模板文档`ustcmb.pdf`. 你也可以参考下面的英文使用说明.

**开发者**: 请查看 [scripts/README.md](scripts/README.md) 了解开发流程和发布方法。

#### Usage

1. download the [zip file](https://gitlab.lug.ustc.edu.cn/vanabel/math-beamer/repository/archive.zip?ref=master) and unzip it
2. get into the root folder of `math-beamer-master-*`, where * is the version of git, open the pdf file [`math-beamer.pdf`](https://gitlab.lug.ustc.edu.cn/vanabel/math-beamer/blob/master/math-beamer.pdf), see the template style
3. if you like it, then you can write your slides in `math-beamer.tex`
4. you will see, there are some options as explained at the begining
 * **thmnum**: numbered theorems
 * **eqsecnum**: number equaiton with section
 * **authoryear**: author-year style reference
 * **allcites**: output all the reference in bib.bib
 * **nds**: not use the default setting
5. **BE CAREFUL** to use the nds options, in that case, you will need to define at least the following options:
* set theme by: `\usetheme{}`, see [beamer-theme-matrix](see http://www.hartwork.org/beamer-theme-matrix/) for a list of themes
* set the title page by add `\frame{\titlepage}` right after the `\begin{document}`
  * set your theorem environment as your thesis, e.g.:  `\newtheorem{thm}{Theorem}`
  * *Optional* set the color theme by: `\usecolortheme{}`, see [index-by-theme-and-color](http://deic.uab.es/~iblanes/beamer_gallery/index_by_theme_and_color.html) for a list of color and theme
6. finally, the reference is proceeded by `amsrefs`, you need to find the `biblatex` data from [AMS MathScinet](http://www.ams.org/mathscinet/)

### 如何升级模板

>说明: 如果你没有使用过该模板, 则无需升级, 直接下载最新版即可使用.

在`v1.2.0`以前, 只需下载并解压最新版zip, 然后将`slides/*`下的文件替换为你自己的内容即可.

从`v1.2.0`升级到`v2.0.0`则需要自己仿照`ustcmb-main.tex`写作(事实上主要是手动`\input sliedes/main.tex`, 其它部分和原来的模板类似).

## 版本历史

### [v2.2.3]

1. 新增`nobib`选项
2. 移除多余的参考文献导航
3. 重新设置中文字体，使得Mac系统和Windows系统都可用
4. 重新配置模板标题/正文字体

### [v2.2.2]

* 新增中文自定义字体命令

### [v2.2.1]

* Fix the `\CJKunderwave` incompatibly

### [v2.2.0]

1. Add `subnav` option: display navigation at each subsection
2. Add example for how to fix the confliction issue of `allowframebreaks` and step display of itemize environment
3. Remove **Thanks!** page, since it should be replaced by a summary of your presentation.

### [v2.1.0]

1. Add SJTU logo
2. Add `domc` for SJTU

### [v2.0.1]

1. Add user FAQ
2. Modify Thanks at last frame based on mode `zh` or `en`

### [v 2.0.0]

1. Use dtx to manage doc
2. Remove xeCJK fontsetting (should be done by user instead)

### [v 1.2.0]

1. Add chinese support option, just use `zh` to support chinese
2. Add default colortheme to be more like USTC color (blue in main)

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

