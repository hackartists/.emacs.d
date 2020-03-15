(setq hackartist-javascript-layers
      '(
        javascript
        json
        ))

(setq hackartist-javascript-packages
      '(
        angular-mode
        angular-snippets
        xref-js2
        js2-refactor
        company-tern
        web-mode
        indium
        emmet-mode web-beautify skewer-mode impatient-mode restclient elnode
        js2-refactor xref-js2 tern js-comint json-mode rjsx-mode))

(setq hackartist-javascript-commands
      '(
        (jsonlint "npm install -g jsonlint")
        (tern "npm install -g tern")
        (eslint "npm install -g eslint")
        (babel-eslint "npm install -g babel-eslint")
        (eslint-plugin-react "npm install -g eslint-plugin-react")
        (eslint-plugin-node "npm install -g eslint-plugin-node")
        (jshint "npm install -g jshint")
        (standard "npm install -g standard")
        (indium "npm install -g indium" )
        ))

(defun hackartist/javascript/init ( )
  (add-hook 'js2-mode-hook
            (lambda ()
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
              )))

(defun hackartist/javascript/config ( )
  (setq xref-show-xrefs-function 'helm-xref-show-xrefs)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-hook 'js-jsx-mode-hook (lambda ()
                                (setq js-indent-level 2)
                                (setq-local sgml-basic-offset js-indent-level)))
  )
