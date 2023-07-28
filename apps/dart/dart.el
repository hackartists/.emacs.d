(setq hackartist-dart-layers
      '(
        (dart :variables dart-backend 'lsp lsp-dart-sdk-dir "/opt/flutter/bin/cache/dart-sdk" lsp-enable-on-type-formatting t dart-server-format-on-save t)
        ))

(defun hackartist/dart/init ()
  (add-hook 'after-save-hook 'hackartist/dart/after-save-hook)
  (add-hook 'before-save-hook 'hackartist/dart/before-save-hook))

(defun hackartist/dart/bindings ()
  "key bindings in dart mode"
  (spacemacs/declare-prefix-for-mode 'dart-mode "f" "flutter")
  (spacemacs/set-leader-keys-for-major-mode 'dart-mode
    "RET" 'lsp-dart-dap-flutter-hot-reload
    "SPC" 'lsp-dart-dap-flutter-hot-restart
    "TAB" 'flutter-run-or-hot-reload)
  )

(defun hackartist/flutter-run-or-hot-restart ()
  "Start `flutter run` or hot-reload if already running."
  (interactive)
  (if (flutter--running-p)
      (flutter-run-or-hot-reload)
    (flutter-run)))

(defun hackartist/dart/before-save-hook ()
  (when (derived-mode-p 'dart-mode)
    (lsp-format-buffer)))

(defun hackartist/dart/after-save-hook ()
  (when (derived-mode-p 'dart-mode)
    (flutter-run-or-hot-reload)))
