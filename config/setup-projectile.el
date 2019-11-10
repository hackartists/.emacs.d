(require 'treemacs)
(require 'treemacs-workspaces)

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :commands (projectile-global-mode)
  :init (setq projectile-enable-caching t)
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-project-root-files '("rebar.config" "project.clj" "build.boot" "SConstruct" "pom.xml" "build.sbt" "gradlew" "build.gradle" ".ensime" "Gemfile" "requirements.txt" "setup.py" "tox.ini" "composer.json" "Cargo.toml" "mix.exs" "stack.yaml" "info.rkt" "DESCRIPTION" "TAGS" "GTAGS" ".dropbox"))
  (projectile-mode +1))

(require 'helm-projectile)
(helm-projectile-on)
(setq projectile-completion-system 'helm)
(setq projectile-indexing-method 'alien)
(setq projectile-git-submodule-command nil)

(defun hackartist/smart-switch-treemacs (path)
  (unless (eq nil path)
    (when (eq nil (treemacs--find-workspace path))
      (message (concat path " workspace will be created."))
      (add-to-list 'treemacs--workspaces (make-treemacs-workspace :name path)  :append)
      (setf (treemacs-current-workspace) (treemacs--select-workspace-by-name path))
      (treemacs-do-add-project-to-workspace path (car (last (delete "" (split-string path "/")))))
      (treemacs--invalidate-buffer-project-cache)
      (treemacs--rerender-after-workspace-change)
      (run-hooks 'treemacs-switch-workspace-hook)
      ))
  )

;; (add-hook 'projectile-after-switch-project-hook (lambda ()
                                                  
;;                                                   (unless (or (eq nil (treemacs-current-workspace))
;;                                                               (eq (treemacs-workspace->name (treemacs-current-workspace)) (projectile-project-root)))
;;                                                     (message "projectile-after-switch")
;;                                                     (message (projectile-project-root))
;;                                                     (hackartist/smart-switch-treemacs (projectile-project-p))
;;                                                     )
;;                                                   ))

(add-hook 'post-command-hook (lambda ()
                               (when (and
                                      (not (eq nil (projectile-project-root)))
                                      (or
                                       (eq nil (treemacs-current-workspace))
                                       (not (string= (treemacs-workspace->name (treemacs-current-workspace)) (projectile-project-root)))))
                                 (hackartist/smart-switch-treemacs (projectile-project-p))
                                 )))

;; (add-hook 'after-init-hook (lambda ()
;;                              (mapc (lambda (project-root)
;;                                      (remhash project-root projectile-project-type-cache)
;;                                      (remhash project-root projectile-projects-cache)
;;                                      (remhash project-root projectile-projects-cache-time)
;;                                      (when projectile-verbose
;;                                        (message "Invalidated Projectile cache for %s."
;;                                                 (propertize project-root 'face 'font-lock-keyword-face)))
;;                                      (when (fboundp 'recentf-cleanup)
;;                                        (recentf-cleanup))))
;;                              ;;(projectile-hash-keys projectile-projects-cache))
;;                              (projectile-serialize-cache)))

(provide 'setup-projectile)
