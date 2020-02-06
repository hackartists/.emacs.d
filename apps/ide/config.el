(defvar ide-load-env-pre-hook nil)
(defvar miniwindow-position 'bottom)

(add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . 0.25)))

(defvar ide-helm-display-buffer-regexp
  `("**"
    (display-buffer-in-side-window)
    (inhibit-same-window . t)
    (side . ,miniwindow-position)
    (window-width . 0.6)
    (window-height . 0.4)))

(defvar ide-display-buffer-regexp
  `("**"
    (window-height . 0.4)))

(defcustom ide-environments
  '("PATH" "MANPATH")
  "List of environment variables which are copied from the shell."
  :type '(repeat (string :tag "Environment variable"))
  :group 'exec-path-from-shell)

(defun ide/get-envs ()
  (exec-path-from-shell-copy-envs ide-environments))

(defun ide/config ()
  (setq shell-file-name "/bin/zsh")
  (ide/get-envs)

  (setq custom-safe-themes t)

  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0)
  (setq company-require-match nil)
  (setq company-lsp-cache-candidates t)

  (setq helm-multi-swoop-edit-save t)
  (setq helm-swoop-split-with-multiple-windows t)
  (setq helm-swoop-split-direction 'split-window-vertically)
  (setq helm-swoop-speed-or-color t)
  (setq helm-display-function 'ide/display-helm-miniwindow)
  (setq helm-swoop-split-window-function 'ide/display-helm-miniwindow)

  (setq projectile-completion-system 'helm)
  (setq projectile-indexing-method 'alien)
  (setq projectile-git-submodule-command nil)
  (setq projectile-project-root-files '("rebar.config" "project.clj" "build.boot" "SConstruct" "pom.xml" "build.sbt" "gradlew" "build.gradle" ".ensime" "Gemfile" "requirements.txt" "setup.py" "tox.ini" "composer.json" "Cargo.toml" "mix.exs" "stack.yaml" "info.rkt" "DESCRIPTION" "TAGS" "GTAGS" ".dropbox" ".projectile"))
  ;; (setq flycheck-display-errors-function 'ide/display-bottom-window)
  

  (customize-set-variable 'helm-ff-lynx-style-map t)
  (customize-set-variable 'helm-imenu-lynx-style-map t)
  (customize-set-variable 'helm-semantic-lynx-style-map t)
  (customize-set-variable 'helm-occur-use-ioccur-style-keys t)
  (customize-set-variable 'helm-grep-use-ioccur-style-keys t))

(defun ide/display-helm-miniwindow (buffer &optional resume)
  "Display the Helm window respecting `helm-position'."
  (let ((display-buffer-alist
         (list ;; ide-helm-display-help-buffer-regexp
               ;; this or any specialized case of Helm buffer must be
               ;; added AFTER `spacemacs-helm-display-buffer-regexp'.
               ;; Otherwise, `spacemacs-helm-display-buffer-regexp' will
               ;; be used before
               ;; `spacemacs-helm-display-help-buffer-regexp' and display
               ;; configuration for normal Helm buffer is applied for helm
               ;; help buffer, making the help buffer unable to be
               ;; displayed.
               ide-helm-display-buffer-regexp)))
    (helm-default-display-buffer buffer)))

;; (defun ide/display-bottom-window (buffer)
;;   "Display a buffer at the bottom of a frame."
;;     (display-buffer-at-bottom buffer ide-display-buffer-regexp))

;; (defun ide/display-bottom-window (buffer)
;;   "Display a buffer at the bottom of a frame."
;;     (display-buffer-at-bottom buffer ide-display-buffer-regexp))
