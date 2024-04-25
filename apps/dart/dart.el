(setq hackartist-dart-layers
      '(
        (dart :variables
              dart-backend 'lsp
              lsp-dart-sdk-dir "/opt/flutter/bin/cache/dart-sdk"
              lsp-enable-on-type-formatting t
              dart-server-format-on-save nil)
        ))

(defun hackartist/dart/init ()
  (setq
   lexical-binding t
   lsp-dart-closing-labels nil
   lsp-dart-flutter-widget-guides nil)
  (add-hook 'before-save-hook 'hackartist/dart/before-save-hook))

(defun hackartist/dart/bindings ()
  "key bindings in dart mode"
  (spacemacs/declare-prefix-for-mode 'dart-mode "f" "flutter")
  (spacemacs/set-leader-keys-for-major-mode 'dart-mode
    "RET" 'lsp-dart-dap-flutter-hot-reload
    "SPC" 'lsp-dart-dap-flutter-hot-restart
    "'" 'hackartist/flutter-run-web-with-build-config
    "d" 'hackartist/dart/dap
    "t" 'hackartist/dart/devtools
    "TAB" 'flutter-run-or-hot-reload))

;; To call dap-debug in your code, you need to install the `dap-mode` package and configure your debugging environment. Here is an example code snippet that demonstrates how to call dap-debug:

;; ```emacs-lisp
;; (require 'dap-mode)
;; (require 'dap-gdb-lldb) ; or dap-gdb-lldb for C/C++ debugging

;; ;; Configure the debugging environment
;; (setq dap-auto-configure-features '(sessions locals breakpoints expressions))
;; (dap-mode 1)
;; (dap-ui-mode 1)

;; ;; Define a debugging configuration
;; (dap-register-debug-template
;;   "My Debug Configuration"
;;   (list :type "gdb/lldb"
;;         :name "My Debug Configuration"
;;         :request "launch"
;;         :target "path/to/your/executable"
;;         :cwd "path/to/your/workspace"))

;; ;; Call dap-debug with the registered configuration
;; (dap-debug "My Debug Configuration")
;; ```

;; Make sure to replace `"path/to/your/executable"` with the actual path to your executable binary and `"path/to/your/workspace"` with the workspace directory where your code is located.

;; Once this code is executed, you can call `(dap-debug "My Debug Configuration")` to start the debugging session with the configured settings.
(defun hackartist/dart/dap ()
  (interactive)
  (dap-register-debug-provider "flutter" 'hackartist/lsp-dart-dap--populate-flutter-start-file-args)
  (dap-register-debug-template "Flutter :: Debug" (list :type "flutter"))
  (dap-register-debug-template "Flutter :: Web Server With .build/config.json"
                               (list
                                :type "flutter"
                                :flutterPlatform "web-server"
                                :name "Flutter :: Web Server With .build/config.json"
                                :toolArgs '("-d" "web-server" "--web-port" "5000" "--web-hostname" "--dart-define-from-file=.build/config.json")
                                ))
  (dap-debug "Flutter :: Debug"))

(defun hackartist/dart/mode-hook ()
  (when (derived-mode-p 'dart-mode)
    (flyspell-mode-off)))

(defun hackartist/dart/config ()
  (add-hook 'dart-mode-hook 'hackartist/dart/mode-hook))

(defun hackartist/flutter-run-or-hot-restart ()
  "Start `flutter run` or hot-reload if already running."
  (interactive)
  (when (flutter--running-p)
    (flutter-hot-restart)))

(defun hackartist/flutter-run-web-with-build-config ()
  (interactive)
  (flutter-run "-d web-server --web-port 5000 --dart-define-from-file=.build/config.json --web-hostname 0.0.0.0"))

(defun hackartist/dart/before-save-hook ()
  (when (derived-mode-p 'dart-mode)
    (lsp-organize-imports)
    (lsp-format-buffer)))

(defun hackartist/dart/after-save-hook ()
  (when (and (derived-mode-p 'dart-mode) (not (eq nil (flutter--running-p))))
    (flutter-hot-restart)))

(defun hackartist/dart/devtools ()
  (interactive)
  (start-process-shell-command "dart-devtools" "*dart devtools*" "dart devtools"))

(defun hackartist/lsp-dart-dap--populate-flutter-start-file-args (conf)
  "Populate CONF with the required arguments for Flutter debug."
  (let ((pre-conf (-> conf
                      lsp-dart-dap--base-debugger-args
                      (dap--put-if-absent :type "flutter")
                      (dap--put-if-absent :flutterMode "debug")
                      (dap--put-if-absent :program (or (lsp-dart-get-project-entrypoint)
                                                       (buffer-file-name))))))
    (lambda (start-debugging-callback)
      (lsp-dart-dap--flutter-get-or-start-device
       (-lambda ((&hash "id" device-id "name" device-name))
         (when (string= device-id "chrome") (setq device-id "web-server"))
         (funcall start-debugging-callback
                  (-> pre-conf
                      (dap--put-if-absent :deviceId device-id)
                      (dap--put-if-absent :deviceName device-name)
                      (dap--put-if-absent :dap-server-path (if (lsp-dart-dap-use-sdk-debugger-p)
                                                               (append (lsp-dart-flutter-command) (list "debug_adapter" "-d" device-id))
                                                             lsp-dart-dap-flutter-debugger-program))
                      (dap--put-if-absent :flutterPlatform "default")
                      (dap--put-if-absent :toolArgs `("-d" ,device-id "--web-port" "5000" "--web-hostname" "0.0.0.0" "--dart-define-from-file" ".build/config.json"))
                      (dap--put-if-absent :name (concat "Flutter (" device-name ")")))))))))
