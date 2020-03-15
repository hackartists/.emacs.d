(setq hackartist-golang-envs
      '("GOPATH" "GOROOT"))

(defun hackartist/golang/config ()
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-sideline-enable t)
  (setq gofmt-command "goimports")
  (setq go-format-before-save t)
  (setq go-tab-width 4)
  (setq gofmt-show-errors nil)
  )
