(setq hackartist-dart-layers
      '(
        (dart :variables dart-backend 'lsp lsp-dart-sdk-dir "/opt/flutter/bin/cache/dart-sdk" dart-lsp-enable-on-type-formatting t dart-server-format-on-save t)
        ))

(defun hackartist/dart/init () 
  (add-hook 'dart-mode-hook (lambda () 
                              (add-hook 'before-save-hook (lambda () 
                                                            (lsp-format-buffer) 
                                                            (flutter-hot-reload) )))))
(defun hackartist/dart/bindings ()
  "key bindings in dart mode"
  (spacemacs/declare-prefix-for-mode 'dart-mode "f" "flutter")
  (spacemacs/set-leader-keys-for-major-mode 'dart-mode
    "RET" 'lsp-dart-dap--flutter-hot-reload
    "SPC" 'flutter-run-or-hot-reload)
  )
