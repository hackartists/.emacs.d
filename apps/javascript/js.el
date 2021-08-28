(setq hackartist-javascript-layers
      '(
        (javascript :variables javascript-import-tool 'import-js javascript-backend 'lsp javascript-repl `nodejs js-indent-level 4 js2-basic-offset 4 javascript-fmt-on-save t javascript-fmt-tool 'prettier node-add-modules-path t)
        (json :variables json-fmt-tool 'prettier json-fmt-on-save t)
        ess
        import-js
        node
        typescript
        react
        html
        ;; tide
        ))

(setq hackartist-javascript-packages
      '(
        angular-mode
        angular-snippets
        xref-js2
        js2-refactor
        web-mode
        ;; indium
        emmet-mode web-beautify skewer-mode impatient-mode restclient elnode
        eslintd-fix
        js-react-redux-yasnippets
        react-snippets
        js-comint json-mode))

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

;; (defun hackartist/javascript/init ( )
;;   ;; (add-hook 'js2-mode-hook
;;   ;;           (lambda ()
;;   ;;             (add-to-list 'company-backends 'company-tern)
;;   ;;             ;; (js2r-add-keybindings-with-prefix "C-c C-r")
;;   ;;             ;; (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)
;;   ;;             (tern-mode +1)
;;   ;;             (company-mode +1)
;;   ;;             (js2-imenu-extras-mode +1)
;;   ;;             (js2-refactor-mode +1)
;;   ;;             (add-hook 'before-save-hook 'tide-format-before-save)

;;   ;;             ;; Key bindings
;;   ;;             ;; (define-key js2-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-expression)
;;   ;;             ;; (define-key js2-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
;;   ;;             ;; (define-key js2-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
;;   ;;             ;; (define-key js2-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)
;;   ;;             ;; (define-key js-mode-map (kbd "M-.") nil)
;;   ;;             ;; (define-key tern-mode-keymap (kbd "M-.") nil)
;;   ;;             ;; (define-key tern-mode-keymap (kbd "M-,") nil)
;;   ;;             ;; (define-key js2-mode-map (kbd "C-k") #'js2r-kill)
;;   ;;             ))
;;   )

(defun hackartist/javascript/init ()
  ;; (add-hook 'js2-mode-hook 'hackartist/javascript/dap-react-native-init)
  )

(defun hackartist/javascript/config ()
  (setq-default
   ;; web-mode
   css-indent-offset 2
   web-mode-markup-indent-offset 2
   web-mode-css-indent-offset 2
   web-mode-code-indent-offset 2
   web-mode-attr-indent-offset 2)

  ;; (setq prettier-js-args
  ;;       '(
  ;;         "--trailing-comma" "all"
  ;;         "--bracket-spacing" "true"
  ;;         "--tab-width" "4"
  ;;         "--semi" "true"
  ;;         "--single-quote" "true"
  ;;         ))
  (with-eval-after-load 'web-mode
    (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil)))

  (add-hook 'js2-mode-hook 'eslintd-fix-mode)
  (add-hook 'js2-mode-hook (lambda () (require 'dap-node))))

(defun hackartist/javascript/bindings ()
  )
;; (defun hackartist/javascript/config ( )
;;   ;; (setq xref-show-xrefs-function 'helm-xref-show-xrefs)
;;   ;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;;   ;; (add-hook 'js-jsx-mode-hook (lambda ()
;;   ;;                               (setq js-indent-level 2)
;;   ;;                               (setq-local sgml-basic-offset js-indent-level))
;;             )
;;   )
(defun hackartist/capitalize-first-char-dirname-base ()
  "Used in snippets. Return buffer base file name, should not throw errors."
  (when (buffer-file-name)
    (js-react-redux-yasnippets-capitalize-first-char (car (last (split-string (buffer-file-name) "/") 2)))))

