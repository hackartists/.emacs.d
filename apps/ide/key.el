(defun ide/company-active-return ()
  (interactive)
  (company-abort)
  (newline-and-indent)
  )

(defun hackartist/ide/bindings ()
  (setq ns-command-modifier 'super)

  (global-set-key (kbd "<s-up>") 'windmove-up)
  (global-set-key (kbd "<s-down>") 'windmove-down)
  (global-set-key (kbd "<s-left>") 'hackartist/ide/windmove-left)
  (global-set-key (kbd "<s-right>") 'hackartist/ide/windmove-right)
  (global-set-key (kbd "<f5>") 'compile)
  (global-set-key (kbd "s-=") 'text-scale-increase)
  (global-set-key (kbd "s--") 'text-scale-decrease)
  (global-set-key (kbd "S-SPC") 'apps/ide/toggle-input-method-custom)
  (global-set-key (kbd "<home>") 'move-beginning-of-line)
  (global-set-key (kbd "<end>") 'move-end-of-line)
  (global-set-key (kbd "RET") 'newline-and-indent)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "C-t") 'helm-mt)
  (global-set-key (kbd "C-c p p") 'helm-projectile-switch-project)
  (global-set-key (kbd "C-c p f") 'helm-projectile-find-file)
  (global-set-key (kbd "s-f") 'helm-swoop)
  (global-set-key (kbd "C-c h i") 'helm-imenu)
  (global-set-key (kbd "C-x b") 'helm-buffers-list)
  (global-set-key (kbd "C-c p s g") 'helm-projectile-grep)
  (global-set-key (kbd "C-r") 'redraw-display)
  (global-set-key (kbd "M-m o s h") 'helm-slack)
  (global-set-key (kbd "s-SPC") 'company-complete)
  (global-set-key (kbd "C-SPC") 'helm-hackartist-buffer)
  (global-set-key (kbd "C-x g") 'magit-status)
  (global-set-key (kbd "C-c C-h i") 'helm-semantic-or-imenu)
  (global-set-key (kbd "s-c") 'cua-copy-region)
  (global-set-key (kbd "s-v") 'cua-paste)
  (global-set-key (kbd "s-x") 'cua-cut-region)
  (global-set-key (kbd "s-k") 'kill-this-buffer)
  (global-set-key (kbd "s-u") 'revert-buffer)
  (global-set-key (kbd "s-a") 'mark-whole-buffer)
  (global-set-key (kbd "s-z") 'undo)
  (global-set-key (kbd "s-'") 'hackartist/ide/switch-or-create-other-frame)
  (global-set-key (kbd "<s-return>") 'yas-insert-snippet)

  (add-hook 'term-mode-hook (lambda()
                              ;;(define-key term-mode-map (kbd "C-t") 'helm-mt)
                              ;;(local-set-key (kbd "C-t") 'helm-mt)
                              (define-key term-raw-map (kbd "<prior>") 'term-pager-back-page)
                              (define-key term-raw-map (kbd "<next>") 'term-pager-page)
                              (define-key term-raw-map (kbd "C-t") 'helm-mt)
                              (define-key term-raw-map (kbd "s-v") 'term-paste)
                              (define-key term-raw-map (kbd "M-c") 'term-line-mode)
                              (define-key term-mode-map (kbd "M-c") 'term-char-mode)
                              (define-key term-raw-map (kbd "<M-left>") 'term-send-backward-word)
                              (define-key term-raw-map (kbd "<M-right>") 'term-send-forward-word)
                              ))

  (eval-after-load 'yasnippet
    (define-key yas-minor-mode-map (kbd "<s-return>") 'yas-insert-snippet))

  (eval-after-load 'company
    '(progn
       (define-key company-active-map (kbd "TAB") 'company-complete)
       (define-key company-active-map (kbd "ESC") 'company-abort)
       (define-key company-active-map (kbd "<return>") 'ide/company-active-return)
       (define-key company-active-map [tab] 'company-complete)))

  (with-eval-after-load 'helm
    (global-set-key (kbd "C-c i") 'helm-imenu)
    (global-set-key (kbd "C-c h i") 'helm-semantic-or-imenu)

    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
    (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
    (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

    ;; (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "M-x") 'helm-M-x)
    (global-set-key (kbd "M-y") 'helm-show-kill-ring)
    (global-set-key (kbd "C-x b") 'helm-mini)
    (global-set-key (kbd "C-x C-f") 'helm-find-files)
    (global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)

    (define-key 'help-command (kbd "C-f") 'helm-apropos)
    (define-key 'help-command (kbd "r") 'helm-info-emacs)
    (define-key 'help-command (kbd "C-l") 'helm-locate-library)

    (add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)

    (define-key minibuffer-local-map (kbd "M-p") 'helm-minibuffer-history)
    (define-key minibuffer-local-map (kbd "M-n") 'helm-minibuffer-history)
    (define-key global-map [remap find-tag] 'helm-etags-select)
    (define-key global-map [remap list-buffers] 'helm-buffers-list)

    (define-key helm-map (kbd "<left>") 'helm-previous-source)
    (define-key helm-map (kbd "<right>") 'helm-next-source))

  (with-eval-after-load 'helm-projectile
    (define-key projectile-mode-map (kbd "C-c p g") 'helm-projectile-grep)
    (define-key projectile-mode-map (kbd "C-c p p") 'helm-projectile-switch-project)
    (define-key projectile-mode-map (kbd "C-c p f") 'helm-projectile-find-file)
    (define-key projectile-mode-map (kbd "C-c p k") 'projectile-kill-buffers)
    (define-key projectile-mode-map (kbd "C-c p s") 'projectile-save-project-buffers))

  )
