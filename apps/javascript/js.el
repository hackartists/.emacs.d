(setq hackartist-javascript-layers
      '(
        (javascript :variables javascript-import-tool
                    'import-js javascript-backend 'lsp javascript-repl
                    `nodejs js-indent-level 2 js2-basic-offset 2
                    javascript-fmt-on-save t javascript-fmt-tool 'prettier
                    node-add-modules-path t)
        (html :variables web-fmt-tool 'prettier web-fmt-on-save t)
        (typescript :variables typescript-fmt-on-save t  typescript-fmt-tool 'prettier
                    typescript-linter 'eslint)
        (json :variables json-fmt-tool 'prettier json-fmt-on-save t)
        import-js
        react
        ;; tide
        ))

(setq hackartist-javascript-packages
      '(;; xref-js2 js2-refactor web-mode
        ;; web-beautify skewer-mode
        ;; impatient-mode restclient elnode
        eslintd-fix
        ;; js-react-redux-yasnippets
        react-snippets
        ;; js-comint json-mode
        ))

(defun hackartist/javascript/init ()
  ;; (add-hook 'js2-mode-hook 'hackartist/javascript/dap-react-native-init)
  (add-hook 'rjsx-mode-hook (lambda ()
                              ;; (setq before-save-hook '(lsp-eslint-apply-all-fixes))
                              (setq lsp-eslint-auto-fix-on-save t))))

(defun hackartist/ts-literal-insert (n)
  (interactive "p")
  (when (fboundp 'copilot-clear-overlay)
    (ignore-errors (copilot-clear-overlay)))
  (when (bound-and-true-p company--active-p)
    (ignore-errors (company-abort)))
  (insert-char last-command-event n))

(defun hackartist/ts-bind-literal-keys ()
  (dolist (k '("," ":" "{" "}" "[" "]" "(" ")" ";" ">" "<" "="))
    (local-set-key (kbd k) #'hackartist/ts-literal-insert)))

(defun hackartist/ts/mode-hook ()
  ;; (copilot-mode -1)
  (local-set-key (kbd "C-<return>") 'copilot-accept-completion)
  (eldoc-mode -1)
  (flycheck-mode -1)
  (smartparens-mode -1))

(defun hackartist/javascript/config ()
  (setq-default
   ;; web-mode
   css-indent-offset 2 web-mode-markup-indent-offset 2 web-mode-css-indent-offset 2
   web-mode-code-indent-offset 2 web-mode-attr-indent-offset 2)

  (add-hook 'typescript-mode-hook 'hackartist/ts/mode-hook)
  (add-hook 'typescript-tsx-mode-hook 'hackartist/ts/mode-hook))

(defun hackartist/javascript/bindings ())

(defun hackartist/capitalize-first-char-dirname-base ()
  "Used in snippets. Return buffer base file name, should not throw errors."
  (when (buffer-file-name)
    (js-react-redux-yasnippets-capitalize-first-char (car (last (split-string (buffer-file-name)
                                                                              "/") 2)))))
