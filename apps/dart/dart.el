(setq hackartist-dart-layers
      '(
        (dart :variables dart-backend 'lsp lsp-dart-sdk-dir "/opt/flutter/bin/cache/dart-sdk" lsp-enable-on-type-formatting t)
        ))

(defun hackartist/dart/init ()
  (add-hook 'dart-mode-hook 'hackartist/dart/before-save-hook))

(defun hackartist/dart/bindings ()
  "key bindings in dart mode"
  (spacemacs/declare-prefix-for-mode 'dart-mode "f" "flutter")
  (spacemacs/set-leader-keys-for-major-mode 'dart-mode
    "RET" 'lsp-dart-dap--flutter-hot-reload
    "SPC" 'flutter-run-or-hot-reload)
  )

(defun hackartist/dart/before-save-hook ()
  (when (derived-mode-p 'dart-mode)
    (lsp-format-buffer)
    (flutter-run-or-hot-reload)))
