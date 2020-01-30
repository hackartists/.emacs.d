(hackartist/core/package/package-install
 '(
   helm
   popup
   helm-mt
   helm-swoop
   helm-ag
   helm-tramp
   helm-projectile
   yasnippet
   command-log-mode
   exec-path-from-shell
   highlight-symbol
   spacemacs-theme
   ))
(setq custom-safe-themes t)

(load-theme 'spacemacs-dark t)
(defun toggle-input-method-custom ()
  (interactive)
  (if (string= default-input-method "korean-hangul")
      (toggle-input-method)
    (set-input-method 'korean-hangul)))  

(setq ns-command-modifier 'super)

(clm/toggle-command-log-buffer)
(global-command-log-mode)
(global-hl-line-mode 1)

(cua-mode 1)
(server-start)
(projectile-mode +1)
(helm-projectile-on)

(global-set-key (kbd "<s-up>") 'windmove-up)
(global-set-key (kbd "<s-down>") 'windmove-down)
(global-set-key (kbd "<s-left>") 'windmove-left)
(global-set-key (kbd "<s-right>") 'windmove-right)
(global-set-key (kbd "s-=") 'text-scale-increase)
(global-set-key (kbd "s--") 'text-scale-decrease)
(global-set-key (kbd "S-SPC") 'toggle-input-method-custom)
(global-set-key (kbd "<home>") 'move-beginning-of-line)
(global-set-key (kbd "<end>") 'move-end-of-line)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-t") 'helm-mt)
(global-set-key (kbd "C-c p p") 'helm-projectile-switch-project)
(global-set-key (kbd "C-c p f") 'helm-projectile-find-file)

(setq shell-file-name "/bin/zsh")

(exec-path-from-shell-initialize)
(exec-path-from-shell-copy-env "GOROOT")
(exec-path-from-shell-copy-env "GOPATH")
(exec-path-from-shell-copy-env "ERLPATH")
(exec-path-from-shell-copy-env "PATH")
(exec-path-from-shell-copy-env "LD_LIBRARY_PATH")

  
;; (require helm)

(with-eval-after-load 'helm
			   (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
			   (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
			   (define-key helm-map (kbd "C-z")  'helm-select-action))

(with-eval-after-load 'helm-projectile
  
  
  )

(with-eval-after-load 'projectile-mode
  (define-key projectile-mode-map (kbd "C-c p k") 'projectile-kill-buffers)
  (define-key projectile-mode-map (kbd "C-c p s") 'projectile-save-project-buffers)
  )

(setq helm-multi-swoop-edit-save t)
(setq helm-swoop-split-with-multiple-windows t)
(setq helm-swoop-split-direction 'split-window-vertically)
(setq helm-swoop-speed-or-color t)

(setq projectile-completion-system 'helm)
(setq projectile-indexing-method 'alien)
(setq projectile-git-submodule-command nil)
(setq projectile-project-root-files '("rebar.config" "project.clj" "build.boot" "SConstruct" "pom.xml" "build.sbt" "gradlew" "build.gradle" ".ensime" "Gemfile" "requirements.txt" "setup.py" "tox.ini" "composer.json" "Cargo.toml" "mix.exs" "stack.yaml" "info.rkt" "DESCRIPTION" "TAGS" "GTAGS" ".dropbox"))

(customize-set-variable 'helm-ff-lynx-style-map t)
(customize-set-variable 'helm-imenu-lynx-style-map t)
(customize-set-variable 'helm-semantic-lynx-style-map t)
(customize-set-variable 'helm-occur-use-ioccur-style-keys t)
(customize-set-variable 'helm-grep-use-ioccur-style-keys t)

(set-face-attribute 'hl-line nil ;; :height (+ (face-attribute 'default :height) 30)
                    :bold t 
                    :underline t 
                    :inherit nil 
                    :background nil)


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
