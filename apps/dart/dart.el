(setq hackartist-dart-layers
      '(
        (dart :variables lsp-dart-sdk-dir "/opt/flutter/bin/cache/dart-sdk" dart-lsp-enable-on-type-formatting t dart-server-format-on-save t)
        ))

(defun hackartist/dart/init () 
  (add-hook 'dart-mode-hook (lambda () 
                              (add-hook 'before-save-hook (lambda () 
                                                            (lsp-format-buffer) 
                                                            (flutter-hot-reload) )))))
