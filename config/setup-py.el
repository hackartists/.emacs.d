;; elpy
(elpy-enable)

;; flycheck
(require 'flycheck)
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(add-hook 'elpy-mode-hook 'remove-keys-set-by-global)
(add-hook 'elpy-mode-hook 'flycheck-mode)
(elpy-use-ipython)

(provide 'setup-py)
