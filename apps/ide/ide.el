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
  (require 'impostman) 
  (require 'ox-moderncv)
  (autoload 'garak "garak" nil t)
  (setq auth-sources '("~/.authinfo")) 
  (add-hook 'minibuffer-setup-hook (lambda () 
                                     (if (string= current-input-method 'korean-hangul) 
                                         (apps/ide/toggle-input-method-custom) 
                                       (setq current-input-method nil)))) 
  (with-eval-after-load 'git-auto-commit-mode 
    (setq gac-automatically-push-p t)) 
  (add-hook 'image-mode-hook (lambda () 
                               (image-transform-fit-to-width)))
  ;;(advice-add 'windmove-do-window-select :after 'advice-after/windmove-do-window-select)
  ;; (add-hook 'minibuffer-setup-hook (lambda ()
  ;; 				      (when minibuffer-completion-table
  ;; 					(with-current-buffer "*Messages*"
  ;; 					  (print minibuffer-completion-table)))))
  (helm-projectile-on) 
  (setq helm-hackartist-buffers-list (make-hackartist-helm-source (helm-make-source "Buffers"
                                                                      'helm-source-buffers)))
  (setq helm-hackartist-projectile-files-list (make-hackartist-helm-source
                                               helm-source-projectile-files-list)) 
  (setq shrface-toggle-bullets t) 
  (savehist-mode -1) 
  (shrface-basic) 
  (shrface-trial) 
  (github-notifier) 
  (elcord-mode 1) 
  (add-hook 'prog-mode-hook (lambda () 
                              (add-hook 'before-save-hook (lambda () 
                                                            (cond ((eq major-mode 'rjsx-mode) 
                                                                   (lsp-eslint-apply-all-fixes)) 
                                                                  ((eq major-mode 'rjsx-mode) 
                                                                   (lsp-eslint-apply-all-fixes)) 
                                                                  ((eq major-mode 'emacs-lisp-mode) 
                                                                   (elisp-format-buffer)) 
                                                                  ((eq major-mode 'go-mode) 
                                                                   (gofmt-before-save)))))))

  ;; (shrface-default-keybindings) ; setup default keybindings
  (advice-add 'forge-visit-pullreq :override 'advice-override/forge-visit-pullreq)
  (setq shrface-href-versatile t))

(defun advice-after/windmove-do-window-select (dir &optional arg window) 
  (treemacs-display-current-project-exclusively))

(defun advice-override/forge-visit-pullreq (pullreq)
  (code-review-forge-pr-at-point))

(advice-add 'emacs-lisp/post-init-company 
            :override 'advice-override/emacs-lisp/post-init-company)
(defun advice-override/emacs-lisp/post-init-company () 
  (spacemacs|add-company-backends :backends company-elisp 
                                  :modes emacs-lisp-mode) 
  (spacemacs|add-company-backends :backends (company-files company-elisp) 
                                  :modes ielm-mode))

(defun hackartist-insert-end (text) (goto-char (point-max)) (inser text))
