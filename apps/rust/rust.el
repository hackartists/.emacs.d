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
  (add-hook 'before-save-hook 'hackartist/rust/before-save-hook))

(defun hackartist/rust/config ()
  "configuration code")

(defun hackartist/rust/bindings ()
  "configuration code")

(defun hackartist/rust/before-save-hook ()
  (when (derived-mode-p 'rustic-mode)
    (lsp-organize-imports)
    (lsp-format-buffer)))
