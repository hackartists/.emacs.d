;;(setq TeX-auto-save t)
;;(setq TeX-parse-self t)
;;(setq TeX-save-query nil)
;(setq TeX-PDF-mode t)

;; (setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
;; (setq ispell-dictionary "english") ; this can obviously be set to any language your spell-checking program supports

;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; (add-hook 'LaTeX-mode-hook 'flyspell-buffer)

(defun turn-on-outline-minor-mode ()
  (outline-minor-mode 1))

(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "\C-c \C-o") ; Or something else


(provide 'setup-tex)
