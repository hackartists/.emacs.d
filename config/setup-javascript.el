(require 'js2-mode)
(require 'js2-refactor)
(require 'xref-js2)
(require 'company)
(require 'company-tern)
(require 'helm-xref)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(setq xref-show-xrefs-function 'helm-xref-show-xrefs)

(add-hook 'js2-mode-hook (lambda ()
                           (add-to-list 'company-backends 'company-tern)
                           (js2r-add-keybindings-with-prefix "C-c C-r")
                           (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)
                           (tern-mode)
                           (company-mode)
                           (js2-imenu-extras-mode)
                           (js2-refactor-mode)
                           (setq js-indent-level 2)

                           ;; Key bindings
                           (define-key js2-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-expression)
                           (define-key js2-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
                           (define-key js2-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
                           (define-key js2-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)
                           (define-key js-mode-map (kbd "M-.") nil)
                           (define-key tern-mode-keymap (kbd "M-.") nil)
                           (define-key tern-mode-keymap (kbd "M-,") nil)
                           (define-key js2-mode-map (kbd "C-k") #'js2r-kill)
                           ))

(add-hook 'js-jsx-mode-hook (lambda ()
                              (setq js-indent-level 2)
                              (setq-local sgml-basic-offset js-indent-level))
          ))

(provide 'setup-javascript)
