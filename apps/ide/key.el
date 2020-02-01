(defun ide/company-active-return ()
  (interactive)
  (company-abort)
  (newline-and-indent)
  )

(defun ide/bindings ()
  (setq ns-command-modifier 'super)

  (global-set-key (kbd "<s-up>") 'windmove-up)
  (global-set-key (kbd "<s-down>") 'windmove-down)
  (global-set-key (kbd "<s-left>") 'windmove-left)
  (global-set-key (kbd "<s-right>") 'windmove-right)
  (global-set-key (kbd "s-=") 'text-scale-increase)
  (global-set-key (kbd "s--") 'text-scale-decrease)
  (global-set-key (kbd "S-SPC") 'apps/ide/toggle-input-method-custom)
  (global-set-key (kbd "<home>") 'move-beginning-of-line)
  (global-set-key (kbd "<end>") 'move-end-of-line)
  (global-set-key (kbd "RET") 'newline-and-indent)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "C-t") 'helm-mt)
  (global-set-key (kbd "C-c p p") 'helm-projectile-switch-project)
  (global-set-key (kbd "C-c p f") 'helm-projectile-find-file)
  (global-set-key (kbd "s-f") 'helm-swoop)
  (global-set-key (kbd "C-c h i") 'helm-imenu)
  (global-set-key (kbd "C-x b") 'helm-buffers-list)
  (global-set-key (kbd "C-c p s g") 'helm-projectile-grep)
  
  (eval-after-load 'yasnippet
    (define-key yas-minor-mode-map (kbd "<s-return>") 'yas-insert-snippet)
    )
  
  (eval-after-load 'company
    '(progn
       (define-key company-active-map (kbd "TAB") 'company-complete)
       (define-key company-active-map (kbd "ESC") 'company-abort)
       (define-key company-active-map (kbd "<return>") 'ide/company-active-return)
       (define-key company-active-map [tab] 'company-complete)))

  (with-eval-after-load 'helm
    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
    (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
    (define-key helm-map (kbd "C-z")  'helm-select-action))

  (with-eval-after-load 'helm-projectile
    
    
    )

  (with-eval-after-load 'projectile-mode
    (define-key projectile-mode-map (kbd "C-c p k") 'projectile-kill-buffers)
    (define-key projectile-mode-map (kbd "C-c p s") 'projectile-save-project-buffers)))

