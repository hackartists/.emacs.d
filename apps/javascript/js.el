(setq hackartist-javascript-layers
      '((javascript :variables javascript-import-tool
                    'import-js javascript-backend 'lsp javascript-repl
                    `nodejs js-indent-level 2 js2-basic-offset 2
                    javascript-fmt-on-save t javascript-fmt-tool 'prettier
                    node-add-modules-path t)
        (html :variables web-fmt-tool 'prettier web-fmt-on-save t)
        (typescript :variables typescript-fmt-on-save t typescript-fmt-tool 'prettier typescript-linter 'eslint)
        (json :variables json-fmt-tool 'prettier json-fmt-on-save t)
        ess import-js node
        react
        ;; tide
        ))

(setq hackartist-javascript-packages
      '(xref-js2 js2-refactor web-mode
                 web-beautify skewer-mode
                 impatient-mode restclient elnode eslintd-fix
                 js-react-redux-yasnippets react-snippets
                 js-comint json-mode))

(setq hackartist-javascript-commands
      '((jsonlint "npm install -g jsonlint")
        (tern "npm install -g tern")
        (eslint "npm install -g eslint")
        (babel-eslint "npm install -g babel-eslint")
        (eslint-plugin-react "npm install -g eslint-plugin-react")
        (eslint-plugin-node "npm install -g eslint-plugin-node")
        (jshint "npm install -g jshint")
        (standard "npm install -g standard")
        (indium "npm install -g indium" )))

(defun hackartist/javascript/init ()
  ;; (add-hook 'js2-mode-hook 'hackartist/javascript/dap-react-native-init)
  (add-hook 'before-save-hook 'hackartist/js/before-save-hook)
  (add-hook 'rjsx-mode-hook (lambda ()
                              ;; (setq before-save-hook '(lsp-eslint-apply-all-fixes))
                              (setq lsp-eslint-auto-fix-on-save t))))

(defun hackartist/js/before-save-hook ()
  (when (or (eq major-mode 'typescript-mode) (eq major-mode 'typescript-tsx-mode))
    (lsp-eslint-fix-all)))

(defun hackartist/javascript/config ()
  (setq-default
   ;; web-mode
   css-indent-offset 2 web-mode-markup-indent-offset 2 web-mode-css-indent-offset 2
   web-mode-code-indent-offset 2 web-mode-attr-indent-offset 2)

  ;; (setq prettier-js-args
  ;;       '(
  ;;         "--trailing-comma" "all"
  ;;         "--bracket-spacing" "true"
  ;;         "--tab-width" "4"
  ;;         "--semi" "true"
  ;;         "--single-quote" "true"
  ;;         ))
  (with-eval-after-load 'web-mode (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
                        (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
                        (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil)))
  (add-hook 'typescript-tsx-mode-hook
            (lambda ()
              (emmet-mode -1)))

  (add-hook 'js2-mode-hook 'eslintd-fix-mode)
  (add-hook 'js2-mode-hook (lambda ()
                             (require 'dap-node))))

(defun hackartist/javascript/bindings ())
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
    (js-react-redux-yasnippets-capitalize-first-char (car (last (split-string (buffer-file-name)
                                                                              "/") 2)))))
