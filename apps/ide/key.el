(defun ide/company-active-return ()
  (interactive)
  (company-abort)
  (newline-and-indent)
  )

(defun hackartist/ide/bindings ()
  (spacemacs/declare-prefix "SPC" "hackartist")
  (spacemacs/declare-prefix "SPC b" "buffers")
  (spacemacs/declare-prefix "SPC e" "evil")
  (spacemacs/declare-prefix "SPC h" "helm")
  (spacemacs/declare-prefix "SPC r" "rings")
  (spacemacs/declare-prefix "SPC s" "sort")
  (spacemacs/set-leader-keys
    "SPC '" 'hackartist/ide/switch-or-create-other-frame
    "SPC ." 'helm-hackartist-buffer
    "SPC RET" 'yas-insert-snippet
    "SPC SPC" 'helm-mt
    "SPC TAB" 'counsel-imenu
    "SPC \\" 'apps/ide/toggle-input-method-custom
    "SPC bk" 'kill-this-buffer
    "SPC bu" 'revert-buffer
    "SPC ei" 'evil-insert
    "SPC hs" 'helm-slack
    "SPC ra" 'helm-all-mark-rings
    "SPC rk" 'helm-show-kill-ring
    "SPC rr" 'helm-mark-ring
    "SPC sc" 'sort-columns
    "SPC sf" 'sort-fields
    )

  (define-key evil-normal-state-map (kbd "+") 'text-scale-increase)
  (define-key evil-normal-state-map (kbd "-") 'text-scale-decrease)
  (define-key evil-normal-state-map (kbd "=") 'text-scale-adjust)
  (define-key evil-normal-state-map (kbd ".") 'spacemacs/jump-to-definition)
  (define-key evil-normal-state-map (kbd ",") 'xref-pop-marker-stack)
  
  (global-set-key (kbd "<s-up>") 'windmove-up)
  (global-set-key (kbd "<s-down>") 'windmove-down)
  (global-set-key (kbd "<s-left>") 'hackartist/ide/windmove-left)
  (global-set-key (kbd "<s-right>") 'hackartist/ide/windmove-right)
  (global-set-key (kbd "<f5>") 'compile)
  ;; (global-set-key (kbd "s-=") 'text-scale-increase)
  ;; (global-set-key (kbd "s--") 'text-scale-decrease)
  (global-set-key (kbd "S-SPC") 'apps/ide/toggle-input-method-custom)
  (global-set-key (kbd "<home>") 'move-beginning-of-line)
  (global-set-key (kbd "<end>") 'move-end-of-line)
  (global-set-key (kbd "RET") 'newline-and-indent)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "s-f") 'helm-swoop)
  (global-set-key (kbd "C-r") 'redraw-display)
  (global-set-key (kbd "M-m o s h") 'helm-slack)
  (global-set-key (kbd "s-SPC") 'company-complete)
  (global-set-key (kbd "C-SPC") 'helm-hackartist-buffer)
  (global-set-key (kbd "s-c") 'cua-copy-region)
  (global-set-key (kbd "s-v") 'cua-paste)
  (global-set-key (kbd "s-x") 'cua-cut-region)
  (global-set-key (kbd "s-k") 'kill-this-buffer)
  (global-set-key (kbd "s-u") 'revert-buffer)
  (global-set-key (kbd "s-a") 'mark-whole-buffer)
  (global-set-key (kbd "s-z") 'undo)
  ;; (global-set-key (kbd "s-'") 'hackartist/ide/switch-or-create-other-frame)
  ;; (global-set-key (kbd "<s-return>") 'yas-insert-snippet)
  (global-set-key (kbd "<M-up>") 'symbol-overlay-jump-prev)
  (global-set-key (kbd "<M-down>") 'symbol-overlay-jump-next)

  ;; (add-hook 'term-mode-hook (lambda()
  ;;                             (define-key term-raw-map (kbd "<prior>") 'term-pager-back-page)
  ;;                             (define-key term-raw-map (kbd "<next>") 'term-pager-page)
  ;;                             (define-key term-raw-map (kbd "C-t") 'helm-mt)
  ;;                             (define-key term-raw-map (kbd "s-v") 'term-paste)
  ;;                             (define-key term-raw-map (kbd "M-c") 'term-line-mode)
  ;;                             (define-key term-mode-map (kbd "M-c") 'term-char-mode)
  ;;                             (define-key term-raw-map (kbd "<M-left>") 'term-send-backward-word)
  ;;                             (define-key term-raw-map (kbd "<M-right>") 'term-send-forward-word)
  ;;                             ))

  (with-eval-after-load 'yasnippet
    (define-key yas-minor-mode-map (kbd "<s-return>") 'yas-insert-snippet))

  (add-hook 'company-mode-hook
            (lambda () (interactive "")
              (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
              (define-key company-active-map (kbd "ESC") 'company-abort)
              (define-key company-active-map (kbd "<return>") 'ide/company-active-return)
              (define-key company-active-map [tab] 'company-complete)))

  (add-hook 'org-mode-hook
            (lambda ()
              (interactive "")
              (define-key org-mode-map (kbd "<M-return>") nil)
              (define-key org-mode-map (kbd "<M-S-up>") nil)
              (define-key org-mode-map (kbd "<M-S-down>") nil)
              (define-key org-mode-map (kbd "<M-up>") nil)
              (define-key org-mode-map (kbd "<M-down>") nil)
              (define-key org-mode-map (kbd "<M-S-left>") nil)
              (define-key org-mode-map (kbd "<M-S-right>") nil)
              (define-key org-mode-map (kbd "<M-left>") nil)
              (define-key org-mode-map (kbd "<S-left>") nil)
              (define-key org-mode-map (kbd "<S-right>") nil)
              (define-key org-mode-map (kbd "<S-up>") nil)
              (define-key org-mode-map (kbd "<S-down>") nil)
              (define-key org-mode-map (kbd "<M-right>") nil) 
              (define-key org-mode-map (kbd "C-<tab>") nil)
              (define-key org-mode-map (kbd "C-S-<tab>") nil)
              (define-key org-mode-map (kbd "<C-up>") nil)
              (define-key org-mode-map (kbd "<C-down>") nil)
              (define-key org-mode-map (kbd "RET") nil)
              (local-set-key (kbd "C-c h i") 'counsel-outline)))


  (with-eval-after-load 'helm
    (global-set-key (kbd "C-c i") 'helm-imenu)
    (global-set-key (kbd "C-c h i") 'helm-semantic-or-imenu)

    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
    (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
    (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

    (global-set-key (kbd "M-x") 'counsel-M-x)
    ;; (global-set-key (kbd "M-x") 'helm-M-x)
    ;; (global-set-key (kbd "M-y") 'helm-show-kill-ring) ;
    (global-set-key (kbd "C-x b") 'helm-mini)
    (global-set-key (kbd "C-x C-f") 'helm-find-files)
    ;; (global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)

    (define-key 'help-command (kbd "C-f") 'helm-apropos)
    (define-key 'help-command (kbd "r") 'helm-info-emacs)
    (define-key 'help-command (kbd "C-l") 'helm-locate-library)

    (add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)

    (define-key minibuffer-local-map (kbd "M-p") 'helm-minibuffer-history)
    (define-key minibuffer-local-map (kbd "M-n") 'helm-minibuffer-history)
    (define-key global-map [remap find-tag] 'helm-etags-select)
    (define-key global-map [remap list-buffers] 'helm-buffers-list)

    (define-key helm-map (kbd "<left>") 'helm-previous-source)
    (define-key helm-map (kbd "<right>") 'helm-next-source)))
