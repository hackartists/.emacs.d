;; rust requires below layers of spacemacs.
(setq hackartist-rust-layers
      '(
        (rust :variables rust-format-on-save t cargo-process-reload-on-modify t)

        ))

;; rust requires additional packages.
(setq hackartist-rust-packages '())

;; rust requires open source code from github
(setq hackartist-rust-osc '())

(defun hackartist/rust/init ()
  "initialization code"
  (require 'lsp-tailwindcss)
  (add-to-list 'lsp-tailwindcss-major-modes 'rustic-mode)
  (add-to-list 'lsp-tailwindcss-major-modes 'rust-mode)
  (setq lsp-tailwindcss-add-on-mode t)


  ;; (lsp-register-client
  ;;  (make-lsp-client
  ;;   :new-connection (lsp-stdio-connection
  ;;                    (lambda ()
  ;;                      `("node" ,(lsp-package-path 'tailwindcss-language-server) "--stdio")))
  ;;   :activation-fn (lsp-activate-on "rust")
  ;;   :server-id 'tailwindcss
  ;;   :priority -1
  ;;   :add-on? t
  ;;   :initialization-options #'lsp-tailwindcss--initialization-options
  ;;   :initialized-fn #'lsp-tailwindcss--company-dash-hack
  ;;   :download-server-fn (lambda (_client callback error-callback _update?)
  ;;                         (lsp-package-ensure 'tailwindcss-language-server callback error-callback))))

  (add-hook 'before-save-hook 'hackartist/rust/before-save-hook)
  (add-hook 'rustic-mode-hook 'hackartist/rust/mode-hook))

;; (defun hackartist/rust/config ()
;;   "configuration code"
;;   (require 'dap-codelldb)
;;   (dap-codelldb-setup)

;; (setq dap-auto-configure-features '(sessions locals controls tooltip))

;; (dap-register-debug-provider
;;  "hackartist-rust"
;;  (lambda (conf)
;;    (plist-put conf :type "lldb")
;;     (plist-put conf :request "launch")
;;     (plist-put conf :miDebuggerPath "~/.cargo/bin/rust-lldb")
;;     (plist-put conf :target nil)
;;     (plist-put conf :cwd (concat (projectile-project-root) "target/debug/"))
;;     (plist-put conf :program (expand-file-name (read-file-name "Select file to debug.")))))
;; (dap-register-debug-template "LLDB::Debug Rust"
;;  (list :type "hackartist-rust" :name "LLDB::Debug Rust Program"))
;; )

(defun hackartist/rust/bindings ()
  "configuration code"
  (spacemacs/declare-prefix-for-mode 'rustic-mode "l" "lsp")
  (spacemacs/set-leader-keys-for-major-mode 'rustic-mode
    "RET" 'dx-translate-on-region

    "l RET" 'lsp-avy-lens
    "l s" 'hackartist/dioxus/server
    "l w" 'hackartist/dioxus/web
    "l l" 'hackartist/dioxus/lambda
    ))

(defun hackartist/rust/before-save-hook ()
  (when (derived-mode-p 'rustic-mode)
    (dx-fmt-before-save)
    (lsp-format-buffer)))

(defun dx-fmt-before-save ()
  "Run `dx fmt -f` on the current file before saving."
  (when buffer-file-name
    (let ((command (format "dx fmt -f %s" (shell-quote-argument buffer-file-name))))
      (shell-command command)
      (revert-buffer t t t))))

(defun dx-translate-on-region (start end)
  "Run `dx translate -r` on the selected region and replace it with the output."
  (interactive "r")
  (let* ((selected-text (buffer-substring-no-properties start end))
         (command (format "dx translate -r %s" (shell-quote-argument selected-text)))
         (output (shell-command-to-string command)))
    ;; Replace the selected text with the output
    (delete-region start end)
    (insert output)))

(defun hackartist/rust/mode-hook ()
  (when (derived-mode-p 'rustic-mode)
    (setq lsp-tailwindcss-experimental-class-regex "class: \"(.*)\"")))

(defun hackartist/dioxus/server ()
  (interactive)
  (setq lsp-rust-features ["server"])
  (lsp-restart-workspace))

(defun hackartist/dioxus/web ()
  (interactive)
  (setq lsp-rust-features ["web"])
  (lsp-restart-workspace))

(defun hackartist/dioxus/lambda ()
  (interactive)
  (setq lsp-rust-features ["lambda"])
  (lsp-restart-workspace))
