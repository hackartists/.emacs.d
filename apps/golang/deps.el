(setq hackartist-golang-layers
      '(
        (go :variables gofmt-command "goimports" go-format-before-save t go-tab-width 4 go-backend 'lsp)
        (lsp :variables lsp-ui-doc-enable nil lsp-ui-sideline-enable t)
        dap
        ))

(setq hackartist-golang-packages
      '(govet gotest gorepl-mode go-stacktracer
              go-snippets go-projectile go-playground go-imports
              go-imenu go-errcheck go-dlv go-direx go-add-tags))
