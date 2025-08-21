# 基本设置 - 强制使用 xelatex
$pdflatex = "xelatex %O %S";
$pdf_mode = 1;
$postscript_mode = 0;
$dvi_mode = 0;

# 明确指定使用 xelatex 而不是 pdflatex
$pdf_previewer_start_cmd = 'open %O %S';
$pdf_previewer_update_method = 0;

# 支持 biblatex (使用 biber)
$biber = 'biber %O %B';

# 支持传统 bibtex
$bibtex = 'bibtex %O %B';

# 索引处理
$makeindex = 'makeindex -s gind.ist %O -o %D %S';

# 词汇表处理
add_cus_dep('glo', 'gls', 0, 'makegls');
sub makegls {
      system("makeindex -s gglo.ist -o \"$_[0].gls\" \"$_[0].glo\"");
}

# 清理扩展名 - 包含 Beamer 特有文件
$clean_ext = 'bbl glo gls hd loa log synctex.gz bcf blg run.xml snm nav aux fdb_latexmk fls vrb out toc';

# 确保在需要时运行参考文献处理
$force_mode = 0;
$recorder = 1;
