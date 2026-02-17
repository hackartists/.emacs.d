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
  ;; (require 'lsp-tailwindcss)
  ;; (add-to-list 'lsp-tailwindcss-major-modes 'rustic-mode)
  ;; (add-to-list 'lsp-tailwindcss-major-modes 'rust-mode)
  ;; (setq lsp-tailwindcss-add-on-mode t)


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
  (add-hook 'rustic-mode-hook 'hackartist/rust/mode-hook)
  )

(defun hackartist/rust/config ()
  "configuration code"
  (require 'dap-codelldb)
  (dap-codelldb-setup)

  (setq dap-auto-configure-features '(sessions locals controls tooltip))

  (dap-register-debug-provider
   "hackartist-rust"
   (lambda (conf)
     ;; NOTE: it's from codelldb
     (let ((debug-port (dap--find-available-port)))
       (plist-put conf :program-to-start (format "%s --port %s" dap-codelldb-debug-program debug-port))
       (plist-put conf :debugServer debug-port))
     (plist-put conf :type "lldb")
     (plist-put conf :request "launch")
     (plist-put conf :host "localhost")
     (plist-put conf :type "lldb")
     (plist-put conf :cargo "")

     ;; NOTE: customized provider for convenience of selecting binary
     (plist-put conf :cwd (rustic-buffer-crate))
     (plist-put conf :program (hackartist/rust/dap-program)
                ;; (expand-file-name
                ;;                (read-file-name
                ;;                 "Select file to debug."
                ;;                 (concat (rustic-buffer-crate) "target/debug/" )
                ;;                 (expand-file-name (concat (rustic-buffer-crate) "target/debug/" (car (last (butlast (string-split (rustic-buffer-crate) "/"))))))
                ;;                 t
                ;;                 (car (last (butlast (string-split (rustic-buffer-crate) "/"))))))
                )))

  (dap-register-debug-template
   "RUST(hackartist): Debug Rust Program by CodeLLDB"
   (list :type "hackartist-rust" :name "Rust(hackartist): Debug Rust Program by CodeLLDB"))

  ;; Register attach debug provider
  (dap-register-debug-provider
   "hackartist-rust-attach"
   (lambda (conf)
     (let ((debug-port (dap--find-available-port)))
       (plist-put conf :program-to-start (format "%s --port %s" dap-codelldb-debug-program debug-port))
       (plist-put conf :debugServer debug-port))
     (plist-put conf :type "lldb")
     (plist-put conf :request "attach")
     (plist-put conf :host "localhost")
     (plist-put conf :pid (hackartist/rust/select-process-pid))
     conf))

  (dap-register-debug-template
   "RUST(hackartist): Attach to Rust Process by CodeLLDB"
   (list :type "hackartist-rust-attach" :name "Rust(hackartist): Attach to Rust Process by CodeLLDB"))

  )

(defun hackartist/rust/build-then (k)
  "Run `make build` in crate root, then call K with the built program path."
  (interactive)
  (let* ((crate (directory-file-name (rustic-buffer-crate)))
         (bin   (car (last (butlast (string-split crate "/")))))
         (prog  (expand-file-name (format "%s/target/debug/%s" crate bin)))
         (default-directory (file-name-as-directory crate)))
    (let ((hook-sym (make-symbol "hackartist--comp-finish")))
      (fset hook-sym
            (lambda (_buf msg)
              (when (string-match-p "finished" msg)
                (remove-hook 'compilation-finish-functions hook-sym)
                (funcall k prog))
              (when (string-match-p "exited abnormally" msg)
                (remove-hook 'compilation-finish-functions hook-sym)
                (message "[build] failed: %s" msg))))
      (add-hook 'compilation-finish-functions hook-sym)
      (compile "make build"))))

(defun hackartist/rust/dap-debug ()
  (interactive)
  (hackartist/rust/build-then
   (lambda (prog)
     (dap-debug (list :type "hackartist-rust"
                      :request "launch"
                      :name "Rust(hackartist): codelldb (after make)"
                      :cwd (rustic-buffer-crate)
                      :program prog)))))

(defun hackartist/rust/dap-program ()
  "configuration code"
  (let* ((default-directory (rustic-buffer-crate)))
    (compile "make build"))

  (expand-file-name (concat (rustic-buffer-crate) "target/debug/" (car (last (butlast (string-split (rustic-buffer-crate) "/")))))))

(defun hackartist/rust/select-process-pid ()
  "Select a process PID from a list, defaulting to the process matching the crate name."
  (let* ((crate-name (car (last (butlast (string-split (rustic-buffer-crate) "/")))))
         (pid (shell-command-to-string (concat "ps -ae | grep " crate-name " | awk '{print $1}'")))
         (selected (if (string-empty-p pid) nil (string-to-number pid))))
    selected))

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
    (lsp-format-buffer)
    (hackartist/rustywind-before-save)))

(defun dx-fmt-before-save ()
  "Format the buffer using `dx fmt` via a temporary file before saving,
if the buffer contains the string `rsx!`. Preserves cursor position and scroll position."
  (when (and buffer-file-name
             (save-excursion
               (goto-char (point-min))
               (search-forward "rsx!" nil t))) ;; Check if `rsx!` exists in the buffer
    (let* ((temp-file (make-temp-file "dx-fmt-")) ;; Create a temporary file
           (command (format "dx fmt -f %s" (shell-quote-argument temp-file))) ;; Command to run
           (cursor-pos (point)) ;; Save the current cursor position
           (scroll-pos (window-start))) ;; Save the scroll position (top of the window)
      ;; Step 1: Write buffer contents to the temporary file
      (write-region (point-min) (point-max) temp-file)
      ;; Step 2: Run the `dx fmt` command on the temporary file
      (if (eq (shell-command command) 0) ;; Check if the command succeeds
          (progn
            ;; Step 3: Replace buffer contents with the formatted temporary file's content
            (erase-buffer)
            (insert-file-contents temp-file)
            ;; Step 4: Restore cursor position
            (goto-char cursor-pos)
            ;; Step 5: Restore the scroll position
            (set-window-start (selected-window) scroll-pos))
        (message "dx fmt failed")) ;; Display a message if the command fails
      ;; Step 6: Clean up the temporary file
      (delete-file temp-file))))

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
    (flycheck-mode -1)
    ))

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

(defun hackartist/rustywind-before-save ()
  (let ((output (with-output-to-string
                  (call-process-region (point-min) (point-max)
                                       "rustywind"
                                       nil (list standard-output nil) nil
                                       "--custom-regex" "class: \"(.*)\""
                                       "--quiet"
                                       "--stdin"
                                       ))))
    (unless (string-empty-p (string-trim output))
      (let ((pos (point)))
        (erase-buffer)
        (insert output)
        (goto-char (min pos (point-max)))))))
