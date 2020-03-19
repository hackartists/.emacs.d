(defun apps/ide/toggle-input-method-custom ()
  (interactive)
  (if (string= default-input-method "korean-hangul")
      (toggle-input-method)
    (set-input-method 'korean-hangul)))  

(defun hackartist/smart-switch-treemacs ()
  (when (and
         (not (eq nil (projectile-project-root)))
         (or
          (eq nil (treemacs-current-workspace))
          (not (string= (treemacs-workspace->name (treemacs-current-workspace)) (projectile-project-root)))))
    (let* ((path (projectile-project-root)))
      (unless (eq nil path)
        (when (eq nil (treemacs--find-workspace path))
          (add-to-list 'treemacs--workspaces (make-treemacs-workspace :name path)  :append)
          (setf (treemacs-current-workspace) (treemacs--select-workspace-by-name path))
          (treemacs-do-add-project-to-workspace path (car (last (delete "" (split-string path "/")))))
          )
        (setf (treemacs-current-workspace) (treemacs--select-workspace-by-name path))
        (treemacs--invalidate-buffer-project-cache)
        (treemacs--rerender-after-workspace-change)
        (run-hooks 'treemacs-switch-workspace-hook)
        (remove-hook 'post-command-hook 'hackartist/smartm-switch-treemacs)
        ))
    ))

(defun toggle-input-method-custom ()
  (interactive)
  (if (string= default-input-method "korean-hangul")
      (toggle-input-method)
    (set-input-method 'korean-hangul)))

(defun hackartist/ide/windmove-left ()
  "docstring"
  (interactive "")
  (if (eq (condition-case nil (windmove-left) (error 1)) 1) (hackartist/ide/other-frame-safe)))

(defun hackartist/ide/windmove-right ()
  "docstring"
  (interactive "")
  (if (eq (condition-case nil (windmove-right) (error 1)) 1) (hackartist/ide/other-frame-safe)))

(defun hackartist/ide/other-frame-safe ()
  (select-frame-set-input-focus (next-frame (selected-frame))))

(defun hackartist/ide/switch-or-create-other-frame ()
  (interactive "")
  (if (eq (next-frame (selected-frame)) (selected-frame)) (make-frame) (hackartist/ide/other-frame-safe)))

(defun helm-hackartist-buffer ()
  "Select hackartist ide using helm."
  (interactive)
  (helm
   :prompt "Hackartist Shell : "
   :sources helm-hackartist-sources-list))

(defun helm-hackartist-buffers-candidates ()
  (let (bufs '())
    (dolist (el (buffer-list)) (push (buffer-name el) bufs))
    bufs
    ))

(defun hackartist-focus-on-window (w)
  (when (windowp w)
    (select-frame-set-input-focus (window-frame w))
    (select-window w)
  ))

(defun helm-hackartist-buffers-persistent-action (candidate)
  (let* ((w (get-buffer-window candidate t)))
    (if w (hackartist-focus-on-window w) (switch-to-buffer candidate))
    ))

(defun make-hackartist-helm-source (s)
  (let* ((src (copy-alist s)))
    (setf (alist-get 'action src) 'helm-hackartist-buffers-persistent-action)
    src))

;; spacemacs//display-helm-window
(defun helm-hackartist-switch-to-buffer (buffer &optional resume)
  (helm-hackartist-buffers-persistent-action buffer))

(defvar helm-hackartist-buffers-list nil)
(defvar helm-hackartist-projectile-files-list nil)
(defvar helm-hackartist-recentf-list nil)

(defcustom helm-hackartist-sources-list
  '(
    helm-hackartist-buffers-list
    helm-hackartist-projectile-files-list
    helm-source-projectile-projects
    #'(helm-make-source "Recentf" 'helm-recentf-source :fuzzy-match helm-recentf-fuzzy-match)
    )
  "Default sources for `helm-hackartist'"
  :type 'list
  :group 'helm-hackartist)

