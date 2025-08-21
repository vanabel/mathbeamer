# You want latexmk to *always* run,
# because make does not have all the info.
# Also, include non-file targets in .PHONY
# so they are run regardless of any
# file of the given name existing.
.PHONY : main cls doc clean all inst install distclean zip git dev-help check-version pre-release release test FORCE_MAKE

NAME = ustcmb
VER= v2.2.6
THEME = beamercolorthemeustc.sty
UTREE = $(shell kpsewhich --var-value TEXMFHOME)
LOCAL = $(shell kpsewhich --var-value TEXMFLOCAL)

# 默认目标
.DEFAULT_GOAL := main

# latexmk: figure out all the LaTeX-related stuff
# -use-make: relying on the Makefile for the Non-LaTeX-related stuff
main : cls FORCE_MAKE
	latexmk -xelatex -shell-escape -use-make

all : main doc

cls : $(NAME).cls

doc : $(NAME).pdf

# '$@' is a variable holding the name of the target, and
# '$<' is a variable holding the (first) dependency of a rule.
$(NAME).cls : $(NAME).dtx
	xetex $<
	@echo "复制类文件到 examples/ 目录..."
	@cp $(NAME).cls examples/ 2>/dev/null || echo "警告: 无法复制 $(NAME).cls 到 examples/ 目录"
	@cp $(NAME).cfg examples/ 2>/dev/null || echo "警告: 无法复制 $(NAME).cfg 到 examples/ 目录"
	@cp beamercolorthemeustc.sty examples/ 2>/dev/null || echo "警告: 无法复制 beamercolorthemeustc.sty 到 examples/ 目录"
	@cp .latexmkrc examples/ 2>/dev/null || echo "警告: 无法复制 .latexmkrc 到 examples/ 目录"
	@echo "类文件复制完成"

$(NAME).pdf : $(NAME).dtx FORCE_MAKE
	latexmk -xelatex $<

# 开发辅助命令
dev-help:
	@echo "ustcmb 开发辅助命令:"
	@echo "  make          - 构建示例文档 (默认)"
	@echo "  make all      - 构建所有文档"
	@echo "  make cls      - 只构建类文件（自动复制到 examples/ 目录）"
	@echo "  make doc      - 只构建文档"
	@echo "  make test     - 测试所有示例文件"
	@echo "  make zip      - 创建发布包"
	@echo "  make check-version - 检查版本一致性"
	@echo "  make pre-release   - 发布前检查"
	@echo "  make release VERSION=v2.2.7 - 发布新版本（替代release.sh）"
	@echo "  make clean    - 清理临时文件（保留 .tex 文件）"
	@echo "  make distclean - 完全清理（保留 .tex 文件）"

# 检查版本一致性
check-version:
	@echo "检查版本一致性..."
	@VERSION_IN_MAKEFILE=$$(grep '^VER=' Makefile | cut -d' ' -f2); \
	VERSION_IN_DTX=$$(grep '^\\ProvidesClass{$(NAME)}' $(NAME).dtx | sed 's/.*v\([0-9\.]*\).*/v\1/'); \
	if [ "$$VERSION_IN_MAKEFILE" != "$$VERSION_IN_DTX" ]; then \
		echo "错误: Makefile版本 ($$VERSION_IN_MAKEFILE) 与DTX版本 ($$VERSION_IN_DTX) 不一致"; \
		exit 1; \
	else \
		echo "版本一致性检查通过: $$VERSION_IN_MAKEFILE"; \
	fi

# 测试所有示例文件
test: cls
	@echo "测试所有示例文件..."
	@echo ""
	@echo "🔍 发现 .tex 文件："
	@cd examples && ls *.tex 2>/dev/null | grep -v '^ustcmb-main\.tex$$' | sort > /tmp/tex_files.txt && cd ..
	@if [ ! -s /tmp/tex_files.txt ]; then echo "❌ 没有找到 .tex 文件"; rm -f /tmp/tex_files.txt; exit 1; fi
	@echo "✅ 找到以下 .tex 文件："
	@cat /tmp/tex_files.txt | sed 's/^/  - /'
	@echo ""
	@echo "📊 总共 $$(cat /tmp/tex_files.txt | wc -l | tr -d ' ') 个示例文件需要测试"
	@echo ""
	@cd examples && for texfile in $$(cat /tmp/tex_files.txt); do \
		basename=$${texfile%.tex}; \
		echo "=== 测试 $$texfile ==="; \
		xelatex -interaction=nonstopmode $$basename > /dev/null 2>&1 && echo "✅ $$basename 第一次编译成功" || (echo "❌ $$basename 第一次编译失败" && exit 1); \
		if [ -f "$$basename.bcf" ]; then \
			biber $$basename > /dev/null 2>&1 && echo "✅ $$basename biber 处理成功" || (echo "❌ $$basename biber 处理失败" && exit 1); \
		elif [ -f "$$basename.bib" ]; then \
			bibtex $$basename > /dev/null 2>&1 && echo "✅ $$basename bibtex 处理成功" || (echo "❌ $$basename bibtex 处理失败" && exit 1); \
		else \
			echo "ℹ️  $$basename 不需要参考文献处理"; \
		fi; \
		xelatex -interaction=nonstopmode $$basename > /dev/null 2>&1 && echo "✅ $$basename 最终编译成功" || (echo "❌ $$basename 最终编译失败" && exit 1); \
		echo "✅ $$basename 测试完成"; \
		echo ""; \
	done && cd ..
	@echo ""
	@echo "=== 测试 latexmk 配置 ==="
	@cd examples && latexmk -C > /dev/null 2>&1 && echo "✅ latexmk 清理成功" || echo "⚠️  latexmk 清理警告" && cd ..
	@cd examples && for texfile in $$(cat /tmp/tex_files.txt); do \
		basename=$${texfile%.tex}; \
		echo "测试 latexmk 编译 $$basename..."; \
		latexmk -pdf $$basename > /dev/null 2>&1 && echo "✅ latexmk 编译 $$basename 成功" || (echo "❌ latexmk 编译 $$basename 失败" && exit 1); \
	done && cd ..
	@cd examples && echo "✅ latexmk 测试完成"
	@echo ""
	@echo "所有测试成功！清理临时文件，只保留 PDF..."
	@cd examples && rm -f *.nav *.snm *.vrb *.xdv *.aux *.log *.fdb_latexmk *.fls *.bbl *.bcf *.blg *.run.xml *.bib *.out *.toc 2>/dev/null || true
	@echo "临时文件清理完成"
	@echo ""
	@echo "🎉 所有示例测试成功完成！"
	@echo ""
	@echo "生成的 PDF 文件："
	@cd examples && echo "📄 PDF 文件列表：" && ls -la *.pdf 2>/dev/null || echo "没有找到 PDF 文件"
	@cd examples && echo ""
	@echo "📊 文件统计：总共有 $$(cd examples && ls *.pdf 2>/dev/null | wc -l | tr -d ' ') 个 PDF 文件"
	@rm -f /tmp/tex_files.txt

# 发布前检查
pre-release: check-version all
	@echo "发布前检查..."
	@# 检查关键文件是否存在
	@test -f $(NAME).cls || (echo "错误: $(NAME).cls 未生成" && exit 1)
	@test -f $(NAME).pdf || (echo "错误: $(NAME).pdf 未生成" && exit 1)
	@test -f $(NAME)-main.pdf || (echo "错误: $(NAME)-main.pdf 未生成" && exit 1)
	@echo "发布前检查完成！"

# 发布新版本（替代release.sh脚本）
release:
	@if [ -z "$(VERSION)" ]; then \
		echo "错误: 请指定版本号"; \
		echo "使用方法: make release VERSION=v2.2.7"; \
		exit 1; \
	fi
	@if [[ ! "$(VERSION)" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$$ ]]; then \
		echo "错误: 版本号格式不正确"; \
		echo "正确格式: v<主版本>.<次版本>.<修订版本>"; \
		echo "例如: v2.2.7"; \
		exit 1; \
	fi
	@echo "开始发布版本: $(VERSION)"
	@echo ""
	@# 检查是否有未提交的更改
	@if [ -n "$$(git status --porcelain)" ]; then \
		echo "警告: 有未提交的更改"; \
		echo "请先提交所有更改，然后继续"; \
		exit 1; \
	fi
	@# 检查是否已经存在该标签
	@if git tag -l | grep -q "^$(VERSION)$$"; then \
		echo "错误: 标签 $(VERSION) 已经存在"; \
		exit 1; \
	fi
	@# 提取版本号部分（去掉v前缀）
	@VERSION_NUM=$$(echo $(VERSION) | sed 's/^v//'); \
	echo "更新文件中的版本信息..."; \
	@# 更新Makefile中的版本号
	@echo "  - 更新Makefile中的版本号..."; \
	@sed "s/VER= v[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*/VER= $(VERSION)/" Makefile > Makefile.bak; \
	@mv Makefile.bak Makefile; \
	@# 更新DTX文件中的版本号
	@echo "  - 更新DTX文件中的版本号..."; \
	@sed "s/\\ProvidesClass{$(NAME)}\\[.*v[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*/\\ProvidesClass{$(NAME)}[2025\/08\/21 $(VERSION)/g" $(NAME).dtx > $(NAME).dtx.bak; \
	@mv $(NAME).dtx.bak $(NAME).dtx; \
	@# 更新README.md中的版本号
	@echo "  - 更新README.md中的版本号..."; \
	@sed "s/Version-v[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*/Version-$$VERSION_NUM/g" README.md > README.md.bak; \
	@mv README.md.bak README.md; \
	@# 更新README_EN.md中的版本号
	@echo "  - 更新README_EN.md中的版本号..."; \
	@sed "s/Version-v[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*/Version-$$VERSION_NUM/g" README_EN.md > README_EN.md.bak; \
	@mv README_EN.md.bak README_EN.md; \
	@# 更新下载链接
	@echo "  - 更新下载链接..."; \
	@sed "s/ustcmb-v[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.zip/ustcmb-$(VERSION).zip/g" README.md > README.md.bak; \
	@mv README.md.bak README.md; \
	@sed "s/ustcmb-v[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.zip/ustcmb-$(VERSION).zip/g" README_EN.md > README_EN.md.bak; \
	@mv README_EN.md.bak README_EN.md; \
	@sed "s/ustcmb-v[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.zip/ustcmb-$(VERSION).zip/g" $(NAME).dtx > $(NAME).dtx.bak; \
	@mv $(NAME).dtx.bak $(NAME).dtx; \
	@# 管理README文件中的版本历史
	@echo "  - 管理README文件中的版本历史..."; \
	@sed "/## 📋 版本历史/,\$$d" README.md > README.md.bak; \
	@echo "" >> README.md.bak; \
	@echo "## 📋 版本历史" >> README.md.bak; \
	@echo "" >> README.md.bak; \
	@echo "### [$(VERSION)]" >> README.md.bak; \
	@echo "" >> README.md.bak; \
	@echo "- ✨ 新增功能和改进" >> README.md.bak; \
	@echo "- 🐛 修复已知问题" >> README.md.bak; \
	@echo "- 📚 更新文档" >> README.md.bak; \
	@echo "" >> README.md.bak; \
	@echo "详细更改请查看 [GitHub提交历史](https://github.com/vanabel/mathbeamer/commits/main)" >> README.md.bak; \
	@mv README.md.bak README.md; \
	@sed "/## 📋 Version History/,\$$d" README_EN.md > README_EN.md.bak; \
	@mv README_EN.md.bak README_EN.md; \
	@echo "版本信息更新完成！"; \
	@echo ""; \
	@# 构建发布包
	@echo "构建发布包..."; \
	@make clean; \
	@make zip; \
	@# 检查发布包是否创建成功
	@ZIP_FILE="ustcmb-$(VERSION).zip"; \
	if [ ! -f "$$ZIP_FILE" ]; then \
		echo "错误: 发布包 $$ZIP_FILE 创建失败"; \
		exit 1; \
	fi; \
	echo "发布包创建成功: $$ZIP_FILE"; \
	@# 提交版本更新和发布包
	@echo "提交版本更新和发布包..."; \
	@git add Makefile $(NAME).dtx README.md README_EN.md "ustcmb-$(VERSION).zip"; \
	@git commit -m "发布版本 $(VERSION)"; \
	@echo ""; \
	@echo "发布流程完成！"; \
	@echo ""; \
	@echo "下一步:"; \
	@echo "1. 运行: git push origin main"; \
	@echo "2. 运行: git tag $(VERSION) && git push origin $(VERSION)"; \
	@echo "3. 等待GitHub Action自动发布到Releases"; \
	@echo ""; \
	@echo "重要说明:"; \
	@echo "- 发布包已在本地构建完成，包含所有必要文件"; \
	@echo "- 需要手动推送更改和标签"; \
	@echo "- GitHub Action只负责将zip文件发布到Releases"

# 创建发布包（优化版本）
zip : pre-release
	@echo "创建发布包 $(NAME)-$(VER)..."
	@mkdir -p $(NAME)-$(VER)/logo $(NAME)-$(VER)/figs
	@# 复制核心文件
	@cp $(NAME).{dtx,cls,pdf,cfg} *.sty \
	  README.md $(NAME)-main.{tex,pdf} \
	  .latexmkrc Makefile LICENSE $(NAME)-$(VER)/
	@# 复制logo文件
	@cp -r logo/{univ,institute}_logo.png logo/ustc logo/sjtu $(NAME)-$(VER)/logo/
	@# 复制图片文件
	@cp -r figs/winfonts.png $(NAME)-$(VER)/figs/
	@# 创建zip包（进入目录避免重复路径）
	@cd $(NAME)-$(VER) && zip -r ../$(NAME)-$(VER).zip . && cd ..
	@# 清理临时目录
	@rm -rf $(NAME)-$(VER)/
	@echo "发布包创建完成: $(NAME)-$(VER).zip"
	@ls -lh $(NAME)-$(VER).zip

clean :
	@echo "开始清理..."
	@latexmk -c 2>/dev/null || true
	@latexmk -c $(NAME).dtx 2>/dev/null || true
	@rm -f $(NAME)-main.{nav,snm,vrb,xdv}
	@echo "清理根目录临时文件..."
	@rm -f *.fls *.fdb_latexmk *.aux *.log *.nav *.snm *.vrb *.xdv *.bbl *.bcf *.blg *.run.xml *.out *.toc 2>/dev/null || true
	@echo "清理 examples/ 目录..."
	@cd examples && latexmk -c 2>/dev/null || true
	@cd examples && echo "清理临时文件，保留 .tex 文件..." && rm -f *.nav *.snm *.vrb *.xdv *.aux *.log *.fdb_latexmk *.fls *.bbl *.bcf *.blg *.run.xml *.bib *.out *.toc 2>/dev/null || true
	@echo "examples/ 目录清理完成（.tex 文件已保留）"

distclean : 
	@echo "开始完全清理..."
	@latexmk -C 2>/dev/null || true
	@latexmk -C $(NAME).dtx 2>/dev/null || true
	@rm -f $(NAME)-main.* *.sty $(NAME).cfg $(NAME).cls $(NAME).ins 
	@rm -f $(NAME)-*.zip
	@echo "清理根目录所有临时文件..."
	@rm -f *.fls *.fdb_latexmk *.aux *.log *.nav *.snm *.vrb *.xdv *.bbl *.bcf *.blg *.run.xml *.out *.toc 2>/dev/null || true
	@echo "完全清理 examples/ 目录..."
	@cd examples && latexmk -C 2>/dev/null || true
	@cd examples && echo "保留 .tex 文件，清理其他所有文件..." && find . -type f ! -name "*.tex" -delete 2>/dev/null || true
	@echo "examples/ 目录完全清理完成（.tex 文件已保留）"

# 安装到用户目录
inst : cls doc main
	mkdir -p $(UTREE)/{tex,source,doc}/latex/{$(NAME), $(NAME)/logo, $(NAME)/figs}
	cp $(NAME).dtx $(UTREE)/source/latex/$(NAME)
	cp $(NAME).ins $(UTREE)/source/latex/$(NAME)
	cp $(NAME).cls $(UTREE)/tex/latex/$(NAME)
	cp $(NAME).cfg $(UTREE)/tex/latex/$(NAME)
	cp $(THEME) $(UTREE)/tex/latex/$(NAME)
	cp README.md $(UTREE)/doc/latex/$(NAME)
	cp $(NAME).pdf $(UTREE)/doc/latex/$(NAME)
	cp $(NAME)-main.tex $(UTREE)/doc/latex/$(NAME)
	cp $(NAME)-main.pdf $(UTREE)/doc/latex/$(NAME)
	cp -r logo/{univ,institute}_logo.png $(UTREE)/doc/latex/$(NAME)/logo/
	cp -r figs/winfonts.png $(UTREE)/doc/latex/$(NAME)/figs/

uninst : 
	rm -drvIf $(UTREE)/{tex,source,doc}/latex/$(NAME)

# 系统级安装
install : cls doc main
	sudo mkdir -p $(UTREE)/{tex,source,doc}/latex/$(NAME)
	sudo cp $(NAME).dtx $(UTREE)/source/latex/$(NAME)
	sudo cp $(NAME).ins $(UTREE)/source/latex/$(NAME)
	sudo cp $(NAME).cls $(UTREE)/tex/latex/$(NAME)
	sudo cp $(NAME).cfg $(UTREE)/tex/latex/$(NAME)
	sudo cp $(THEME) $(UTREE)/tex/latex/$(NAME)
	sudo cp README.md $(UTREE)/doc/latex/$(NAME)
	sudo cp $(NAME).pdf $(UTREE)/doc/latex/$(NAME)
	sudo cp $(NAME)-main.tex $(UTREE)/doc/latex/$(NAME)
	sudo cp $(NAME)-main.pdf $(UTREE)/doc/latex/$(NAME)
	cp -r logo/{univ,institute}_logo.png $(UTREE)/doc/latex/$(NAME)/logo/
	cp -r figs/winfonts.png $(UTREE)/doc/latex/$(NAME)/figs/

uninstall:
	sudo rm -drvIf $(UTREE)/{tex,source,doc}/latex/$(NAME)

# Git相关操作（保留原有功能）
git : zip
	cp -r logo/{univ,institute}_logo.png logo/ustc logo/sjtu mathbeamer/logo/
	cp -r figs/winfonts.png $(NAME)-$(VER)/figs
	cp $(NAME).dtx Makefile .latexmkrc $(NAME)-$(VER).zip mathbeamer/
