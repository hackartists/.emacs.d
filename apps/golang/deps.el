(setq hackartist-golang-layers '((go :variables gofmt-command 
                                     "goimports" go-format-before-save nil go-tab-width 4 go-backend
                                     'lsp godoc-at-point-function 'godoc-gogetdoc)))

(setq hackartist-golang-packages '(govet gotest gorepl-mode go-stacktracer helm-go-package
                                         go-snippets go-projectile go-playground go-imports go-imenu
                                         go-errcheck go-dlv go-direx go-add-tags hover))
