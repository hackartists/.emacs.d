(defun hackartist/golang/init ()
  (add-hook #'lsp-deferred)
  (add-hook 'before-save-hook 'hackartist/go/before-save-hook))

(defun go/pre-init-dap-mode ()
  (add-to-list 'spacemacs--dap-supported-modes 'go-mode))

(defun hackartist/go/before-save-hook ()
  (when (derived-mode-p 'go-mode)
    (lsp-organize-imports)
    (lsp-format-buffer)))
