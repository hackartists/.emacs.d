(defun hackartist/org-latex/classes ()
  (org-latex/template/journal))

(defun org-latex/template/journal ()
  (add-to-list 'org-latex-classes
               '("journal"
                 "\\documentclass[journal]{journal}
\\usepackage[T1]{fontenc}%
\\usepackage[backend=bibtex]{biblatex}
\\usepackage[utf8]{inputenc}
\\usepackage{kotex}
\\usepackage{rotating}
\\usepackage{graphicx}
\\usepackage{amssymb,amsmath}
\\usepackage{amsthm}
\\usepackage{algorithmic}
\\usepackage[ruled,linesnumbered]{algorithm2e}
\\usepackage{listings}
\\usepackage[titletoc]{appendix}
\\usepackage{rotating}
\\usepackage{multirow}
\\usepackage{array}
\\usepackage{supertabular}
\\usepackage{dcolumn}
\\usepackage{adjustbox}
\\usepackage{epsfig}
\\usepackage{subfigure}
\\usepackage{acronym}
\\usepackage{url}
\\usepackage{graphicx}
\\usepackage{mathtools}
\\usepackage{longtable}
\\usepackage[acronym,nomain]{glossaries}
\\usepackage[font=small,skip=0pt]{caption}
\\usepackage{xcolor}
\\usepackage{color}
\\usepackage{colortbl}
\\usepackage{tikz}
\\usepackage{lmodern}
\\usepackage{blindtext}
\\usepackage{etoolbox}
"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
