(setq hackartist-golang-envs
      '("GOPATH" "GOROOT"))

(defun hackartist/golang/config ()
  (setq gofmt-command "goimports"
        go-format-before-save t
        go-tab-width 4
        gofmt-show-errors nil
        go-backend 'lsp

        lsp-ui-doc-enable nil
        lsp-ui-sideline-enable t)
  (custom-set-variables
   '(go-add-tags-style 'snake-case)
   '(go-tag-args '("-transform" "camelcase")))
  (add-hook 'go-mode-hook #'lsp))
