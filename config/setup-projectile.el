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


(provide 'setup-projectile)
