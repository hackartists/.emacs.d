;; Package: projejctile
(require 'projectile)
(setq use-package-verbose t
      use-package-enable-imenu-support t)
(require 'use-package)

(use-package projectile
             :ensure t
             :diminish projectile-mode
             :commands (projectile-global-mode)
             :init (setq projectile-enable-caching t)
             :config (projectile-global-mode 1))

(projectile-global-mode)

(require 'helm-projectile)
(helm-projectile-on)
(setq projectile-completion-system 'helm)
(setq projectile-indexing-method 'alien)

(add-hook 'projectile-after-switch-project-hook (lambda ()
                                                  (projectile-invalidate-cache nil)))


(add-hook 'after-init-hook (lambda ()
                             (mapc (lambda (project-root)
                                     (remhash project-root projectile-project-type-cache)
                                     (remhash project-root projectile-projects-cache)
                                     (remhash project-root projectile-projects-cache-time)
                                     (when projectile-verbose
                                       (message "Invalidated Projectile cache for %s."
                                                (propertize project-root 'face 'font-lock-keyword-face)))
                                     (when (fboundp 'recentf-cleanup)
                                       (recentf-cleanup))))
                                   ;;(projectile-hash-keys projectile-projects-cache))
                             (projectile-serialize-cache)))

(provide 'setup-projectile)
