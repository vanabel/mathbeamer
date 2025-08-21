# You want latexmk to *always* run,
# because make does not have all the info.
# Also, include non-file targets in .PHONY
# so they are run regardless of any
# file of the given name existing.
.PHONY : main cls doc clean all inst install distclean zip git dev-help check-version pre-release FORCE_MAKE

NAME = ustcmb
VER= v2.2.3
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

$(NAME).pdf : $(NAME).dtx FORCE_MAKE
	latexmk -xelatex $<

# 开发辅助命令
dev-help:
	@echo "ustcmb 开发辅助命令:"
	@echo "  make          - 构建示例文档 (默认)"
	@echo "  make all      - 构建所有文档"
	@echo "  make cls      - 只构建类文件"
	@echo "  make doc      - 只构建文档"
	@echo "  make zip      - 创建发布包"
	@echo "  make check-version - 检查版本一致性"
	@echo "  make pre-release   - 发布前检查"
	@echo "  make clean    - 清理临时文件"
	@echo "  make distclean - 完全清理"

# 检查版本一致性
check-version:
	@echo "检查版本一致性..."
	@VERSION_IN_MAKEFILE=$$(grep '^VER=' Makefile | cut -d' ' -f2); \
	VERSION_IN_DTX=$$(grep '\\ProvidesPackage.*ustcmb' $(NAME).dtx | sed 's/.*\[\(.*\)\].*/\1/'); \
	if [ "$$VERSION_IN_MAKEFILE" != "$$VERSION_IN_DTX" ]; then \
		echo "错误: Makefile版本 ($$VERSION_IN_MAKEFILE) 与DTX版本 ($$VERSION_IN_DTX) 不一致"; \
		exit 1; \
	else \
		echo "版本一致性检查通过: $$VERSION_IN_MAKEFILE"; \
	fi

# 发布前检查
pre-release: check-version all
	@echo "发布前检查..."
	@# 检查关键文件是否存在
	@test -f $(NAME).cls || (echo "错误: $(NAME).cls 未生成" && exit 1)
	@test -f $(NAME).pdf || (echo "错误: $(NAME).pdf 未生成" && exit 1)
	@test -f $(NAME)-main.pdf || (echo "错误: $(NAME)-main.pdf 未生成" && exit 1)
	@echo "发布前检查完成！"

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
	@# 创建zip包
	@zip -r $(NAME)-$(VER).zip $(NAME)-$(VER)/
	@# 清理临时目录
	@rm -rf $(NAME)-$(VER)/
	@echo "发布包创建完成: $(NAME)-$(VER).zip"
	@ls -lh $(NAME)-$(VER).zip

clean :
	latexmk -c
	latexmk -c $(NAME).dtx
	rm -f $(NAME)-main.{nav,snm,vrb,xdv}

distclean : 
	latexmk -C
	latexmk -C $(NAME).dtx
	rm -f $(NAME)-main.* *.sty $(NAME).cfg $(NAME).cls $(NAME).ins 
	rm -f $(NAME)-*.zip

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
	cp -r logo/{univ,institute}_logo.png logo/ustc logo/sjtu math-beamer/logo/
	cp -r figs/winfonts.png $(NAME)-$(VER)/figs
	cp $(NAME).dtx Makefile .latexmkrc $(NAME)-$(VER).zip math-beamer/
