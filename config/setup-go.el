(add-hook 'go-mode-hook (lambda ()
                          (setq flycheck-disabled-checkers '(lsp-ui))))


(defun my-go-playground-mode-hook ()
  (define-key go-playground-mode-map (kbd "<M-return>") 'go-playground-exec)
  (define-key go-playground-mode-map (kbd "<s-return>") 'yas-insert-snippet)
  )

(add-hook 'go-playground-mode-hook 'my-go-playground-mode-hook)

(provide 'setup-go)
