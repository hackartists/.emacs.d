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

  ;; (add-hook 'minibuffer-setup-hook (lambda ()
  ;; 				      (when minibuffer-completion-table
  ;; 					(with-current-buffer "*Messages*"
  ;; 					  (print minibuffer-completion-table)))))
  (advice-add 'org-hugo-export-wim-to-md :before #'hackartist/ide/advice-before/org-hugo-export-wim-to-md)
  (advice-add 'org-hugo-export-wim-to-md :after #'hackartist/ide/advice-after/org-hugo-export-wim-to-md)
  )

(defun hackartist/ide/advice-before/org-export-to-file (backend file &optional async subtreep visible-only body-only ext-plist post-process)
  (delete-file file))

(defun hackartist/ide/advice-before/org-hugo-export-wim-to-md (&optional all-subtrees async visible-only noerror)
  (advice-add 'org-export-to-file :before #'hackartist/ide/advice-before/org-export-to-file))

(defun hackartist/ide/advice-after/org-hugo-export-wim-to-md (&optional all-subtrees async visible-only noerror)
  (advice-remove 'org-export-to-file #'hackartist/ide/org-hugo-export-wim-to-md-before-hook))
