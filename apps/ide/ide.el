(defun ide/init ()
  (global-linum-mode +1)
  (global-company-mode +1)
  (cua-mode 1)
  (yas-global-mode +1)
  (projectile-mode +1)
  (global-undo-tree-mode +1)
  (helm-projectile-on)

     ;; (add-hook 'minibuffer-setup-hook (lambda ()
     ;; 				      (when minibuffer-completion-table
     ;; 					(with-current-buffer "*Messages*"
     ;; 					  (print minibuffer-completion-table)))))
  )
