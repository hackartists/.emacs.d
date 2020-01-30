(hackartist/core/package/package-install
 '(
   company
   company-go
   counsel-gtags
   ;; eldoc				;
   flycheck
   ;; (flycheck-golangci-lint :toggle (and go-use-golangci-lint
   ;;                                      (configuration-layer/package-used-p
   ;;                                       'flycheck)))
   ggtags
   helm-gtags
   go-eldoc
   go-fill-struct
   go-gen-test
   go-guru
   go-impl
   go-mode
   go-rename
   go-tag
   godoctor
   popwin
   lsp-mode
   lsp-ui
   company-lsp
   helm-lsp
   lsp-treemacs
   ))

(setq lsp-ui-doc-enable nil)
(setq lsp-ui-sideline-enable t)
(setq gofmt-command "goimports")
(setq go-format-before-save t)
(setq go-tab-width 4)
(add-hook 'go-mode-hook #'lsp)
;; (push 'company-lsp company-backends)

;; '(lsp-ui-sideline-code-action ((t (:foreground "dim gray"))))

(add-hook 'go-mode-hook (lambda ()
			  (flycheck-mode)
			  ))
