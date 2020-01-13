(defun spacemacs//init-jump-handlers-java-mode ()
  (interactive)
  (require 'lsp-java)
  (require 'dap-java)

  (add-hook 'before-save-hook (lambda ()
                                (lsp-format-buffer)
                                (lsp-java-organize-imports)
                                ))
  )

(defun java/pre-init-dap-mode ()
  (add-to-list 'spacemacs--dap-supported-modes 'java-mode))

(provide 'setup-java)
