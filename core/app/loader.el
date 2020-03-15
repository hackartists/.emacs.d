(setq hackartist-packages '())
(setq hackartist-layers '())
(setq hackartist-apps '())
(setq hackartist-osc '())
(setq dotspacemacs-additional-packages '())
(setq hackartist-vendor-dir (concat emacs-start-directory "/libs"))

(defcustom hackartist-environments
  '("PATH" "MANPATH" "ERLPATH" "LD_LIBRARY_PATH")
  "List of environment variables which are copied from the shell."
  :type '(repeat (string :tag "Environment variable"))
  :group 'exec-path-from-shell)
(setq shell-file-name "/bin/zsh")


(defun core/app/load-apps ()
  (let ((res)
        (app-dir (concat emacs-start-directory "/apps")))
    (let (
          (app-files (append (directory-files-recursively app-dir ".*\.el$")))
          (apps (nthcdr 2 (directory-files app-dir))))
      (dolist (el app-files res)
        (load-file el))
      (dolist (el apps res)
        (add-to-list 'hackartist-apps el)
        (core/app/app-deps el))
      (dolist (el hackartist-packages) (add-to-list 'dotspacemacs-additional-packages el))
      (core/app/load-osc)
      )))

(defun core/app/app-deps (pkg)
  (let* ((pkgs (intern (concat "hackartist-"  pkg "-packages")))
         (lys (intern (concat "hackartist-"  pkg "-layers")))
         (envs (intern (concat "hackartist-"  pkg "-envs")))
         (osc (intern (concat "hackartist-"  pkg "-osc")))
         )
    (condition-case nil
        (dolist (el (symbol-value pkgs)) (add-to-list 'hackartist-packages el))
      (error "not define packages"))
    (condition-case nil
        (dolist (el (symbol-value lys)) (add-to-list 'hackartist-layers el))
      (error "not define layers"))
    (condition-case nil
        (dolist (el (symbol-value envs)) (add-to-list 'hackartist-environments el))
      (error "not define environments"))
    (condition-case nil
        (dolist (el (symbol-value osc)) (add-to-list 'hackartist-osc el))
      (error "not define open source libraries"))))

(defun core/app/load-osc ()
  (dolist (el hackartist-osc) (core/app/load-osc|clone-load el)))

(defun core/app/load-osc|clone-load (osc)
  (let* ((name (replace-regexp-in-string ".git" "" (nth 0 (last (split-string osc "/")))))
         (lp (concat hackartist-vendor-dir "/" name))
         (cmd (concat "git clone " osc " " lp)))
    (unless (file-exists-p (concat hackartist-vendor-dir "/" name))
      (message cmd)
      (shell-command cmd))
    (push lp load-path)))


(defun core/app/init-apps ()
  (exec-path-from-shell-copy-envs hackartist-environments)
  (dolist (el hackartist-apps)
    (core/app/init-app el)))

(defun core/app/init-app (app)
  (let ((init (intern (concat "hackartist/" (concat app "/init"))))
        (config (intern (concat "hackartist/" (concat app "/config"))))
        (bindings (intern (concat "hackartist/" (concat app "/bindings")))))
    (condition-case nil (funcall init) (error (concat (symbol-name init) " function does not defined")))
    (condition-case nil (funcall config) (error (concat (symbol-name config) " function does not defined")))
    (condition-case nil (funcall bindings) (error (concat (symbol-name bindings) " function does not defined")))))
