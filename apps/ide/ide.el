(defun hackartist/ide/init ()
  ;; (global-company-mode +1)
  ;; (cua-mode 1)
  ;; (yas-global-mode +1)
  ;; (projectile-mode +1)
  ;; (global-undo-tree-mode +1)
  ;; (helm-projectile-on)
  ;; (recentf-mode +1)
  ;; (global-git-gutter+-mode -1)
  ;; (global-auto-highlight-symbol-mode +1)
  (setq auth-sources '("~/.authinfo"))
  (add-hook 'minibuffer-setup-hook
            (lambda ()
              (if (string= current-input-method 'korean-hangul)
                  (apps/ide/toggle-input-method-custom)
                (setq current-input-method nil)
                )))
  (add-hook 'image-mode-hook (lambda () (image-transform-fit-to-width)))
  ;;(advice-add 'windmove-do-window-select :after 'advice-after/windmove-do-window-select)
  ;; (add-hook 'minibuffer-setup-hook (lambda ()
  ;; 				      (when minibuffer-completion-table
  ;; 					(with-current-buffer "*Messages*"
  ;; 					  (print minibuffer-completion-table)))))
  (helm-projectile-on)
  (setq helm-hackartist-buffers-list (make-hackartist-helm-source (helm-make-source "Buffers" 'helm-source-buffers)))
  (setq helm-hackartist-projectile-files-list (make-hackartist-helm-source helm-source-projectile-files-list))

  (setq shrface-toggle-bullets t)
  (shrface-basic)
  (shrface-trial)
  (github-notifier-mode t)
  ;; (shrface-default-keybindings) ; setup default keybindings
  (setq shrface-href-versatile t))


(defun advice-after/windmove-do-window-select (dir &optional arg window)
  (treemacs-display-current-project-exclusively))
