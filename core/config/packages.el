(setq hackartist-configuration-layers '(react
                                       systemd
                                       (go :variables gofmt-command "goimports" go-format-before-save t go-tab-width 4 go-backend 'lsp)
                                       (lsp :variables lsp-ui-doc-enable nil lsp-ui-sideline-enable t)
                                       (multiple-cursors :variables multiple-cursors-backend 'mc)
                                       (python :variables python-format-on-save t python-sort-imports-on-save t python-test-runner 'pytest python-test-runner '(pytest nose))
                                       (ruby :variables ruby-enable-enh-ruby-mode t ruby-backend 'robe ruby-version-manager 'rvm ruby-test-runner 'rspec)
                                       ;; (c-c++ :variables c-c++-backend 'lsp-clangd c-c++-adopt-subprojects t c-c++-lsp-enable-semantic-highlight 'rainbow c-c++-default-mode-for-headers 'c++-mode c++-enable-organize-includes-on-save t c-c++-enable-clang-format-on-save t c-c++-enable-google-style t c-c++-enable-google-newline t c-c++-enable-auto-newline t)
                                       ;; auto-completion
                                       ;; better-defaults
                                       ;; mu4e
                                       ;; neotree
                                       ;; scala
                                       asm
                                       better-defaults
                                       bibtex
                                       bm
                                       chrome
                                       cmake
                                       command-log
                                       confluence
                                       csv
                                       dap
                                       dart
                                       debug
                                       docker
                                       emacs-lisp
                                       erlang
                                       ess
                                       git
                                       gpu
                                       graphviz
                                       groovy
                                       ;; helm
                                       html
                                       ibuffer
                                       imenu-list
                                       import-js
                                       ivy
                                       java
                                       javascript
                                       json
                                       kotlin
                                       latex
                                       markdown
                                       nginx
                                       node
                                       (org :variables org-enable-github-support t org-enable-bootstrap-support t org-enable-bootstrap-support t org-projectile-file "TODOs.org")
                                       osx
                                       php
                                       restclient
                                       rust
                                       semantic
                                       shell
                                       slack
                                       smex
                                       spell-checking
                                       sql
                                       swift
                                       syntax-checking
                                       treemacs
                                       typescript
                                       typography
                                       unicode-fonts
                                       version-control
                                       yaml
                                       ))
