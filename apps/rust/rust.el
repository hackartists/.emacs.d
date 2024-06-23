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
  (add-to-list 'lsp-tailwindcss-major-modes 'rustic-mode)
  (add-hook 'before-save-hook 'hackartist/rust/before-save-hook)
  (add-hook 'rustic-mode-hook 'hackartist/rust/mode-hook))

(defun hackartist/rust/config ()
  "configuration code")

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
    (setq lsp-tailwindcss-experimental-class-regex "class: \"(.*)\"")
    (setq lsp-tailwindcss-add-on-mode t)))
