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
  (spacemacs/set-leader-keys-for-minor-mode 'rustic-mode
    "l RET" 'lsp-avy-lens))

(defun hackartist/rust/before-save-hook ()
  (when (derived-mode-p 'rustic-mode)
    (lsp-format-buffer)))

(defun hackartist/rust/mode-hook ()
  (when (derived-mode-p 'rustic-mode)
    (setq lsp-tailwindcss-experimental-class-regex "class: \"(.*)\"")))
