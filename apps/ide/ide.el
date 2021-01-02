(defun hackartist/ide/init ()
  (global-company-mode +1)
  (cua-mode 1)
  (yas-global-mode +1)
  (projectile-mode +1)
  (global-undo-tree-mode +1)
  (helm-projectile-on)
  (recentf-mode +1)
  (global-git-gutter+-mode -1)
  (global-auto-highlight-symbol-mode +1)
  (setq auth-sources '("~/.authinfo"))
  (require 'ob-api)
  (require 'ob-api-mode)
  (require 'ob-async)
  (require 'ob-go)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((api . t)))

  (add-hook 'minibuffer-setup-hook
            (lambda ()
              (if (string= current-input-method 'korean-hangul)
                  (toggle-input-method-custom)
                (setq current-input-method nil)
                )))

  ;; (add-hook 'minibuffer-setup-hook (lambda ()
  ;; 				      (when minibuffer-completion-table
  ;; 					(with-current-buffer "*Messages*"
  ;; 					  (print minibuffer-completion-table)))))
  )
