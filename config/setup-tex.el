(use-package auctex
  :requires ( company-auctex )
  )

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)

(setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
(setq ispell-dictionary "english") ; this can obviously be set to any language your spell-checking program supports

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)
;;(add-hook 'LaTeX-mode-hook 'linum-mode)
(defun turn-on-outline-minor-mode ()
  (outline-minor-mode 1))

(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "\C-c \C-o") ; Or something else

(add-hook 'LaTeX-mode-hook
          (lambda()
            (require 'company-auctex)
            (company-auctex-init)
            )
          )

(eval-after-load "tex"
  '(add-to-list 'TeX-command-list
		'("Pdflatex" "pdflatex %s" TeX-run-command nil t :help "Run pdflatex") t))


(provide 'setup-tex)
