# You want latexmk to *always* run,
# because make does not have all the info.
# Also, include non-file targets in .PHONY
# so they are run regardless of any
# file of the given name existing.
.PHONY : main cls doc clean all inst install distclean zip FORCE_MAKE

NAME = ustcmb
VER= v2.2.3
THEME = beamercolorthemeustc.sty
UTREE = $(shell kpsewhich --var-value TEXMFHOME)
LOCAL = $(shell kpsewhich --var-value TEXMFLOCAL)
# make without parameter will use make main
# rule of make: target can be object file or a label
# 	prerequisites are the target dependence (file or label)
# 	if prerequisites are newer than target use command to rebuilt
# target : prerequisites
# command

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

clean :
	latexmk -c
	latexmk -c $(NAME).dtx
	rm -f $(NAME)-main.{nav,snm,vrb,xdv}

distclean : 
	latexmk -C
	latexmk -C $(NAME).dtx
	rm $(NAME)-main.* *.sty $(NAME).cfg $(NAME).cls $(NAME).ins 

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
	
zip : cls doc main
	mkdir $(NAME)-$(VER) $(NAME)-$(VER)/logo
	cp -r $(NAME).{dtx,cls,pdf,cfg} *.sty \
	  README.md $(NAME)-main.{tex,pdf} \
	  .latexmkrc Makefile $(NAME)-$(VER)
	cp -r logo/{univ,institute}_logo.png logo/ustc logo/sjtu $(NAME)-$(VER)/logo
	cp -r figs/winfonts.png $(NAME)-$(VER)/figs
	zip -r $(NAME)-$(VER).zip $(NAME)-$(VER)
	rm -r $(NAME)-$(VER)

git : zip
	cp -r logo/{univ,institute}_logo.png logo/ustc logo/sjtu math-beamer/logo/
	cp -r figs/winfonts.png $(NAME)-$(VER)/figs
	cp $(NAME).dtx Makefile .latexmkrc $(NAME)-$(VER).zip math-beamer/
