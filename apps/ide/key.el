(defun ide/company-active-return ()
  (interactive)
  (company-abort)
  (newline-and-indent))

(defun hackartist/xdg-open ()
  (interactive)
  (shell-command "xdg-open ."))

(defun hackartist/ide/bindings ()
  (spacemacs/declare-prefix "SPC" "hackartist")
  (spacemacs/declare-prefix "SPC b" "buffers")
  (spacemacs/declare-prefix "SPC e" "evil")
  (spacemacs/declare-prefix "SPC h" "helm")
  (spacemacs/declare-prefix "SPC r" "rings")
  (spacemacs/declare-prefix "SPC s" "sort")
  (spacemacs/declare-prefix "SPC k" "kmacro")
  (spacemacs/declare-prefix "SPC g" "git")
  (spacemacs/declare-prefix "SPC w" "window")
  (spacemacs/declare-prefix "SPC f" "file/directory")
  (spacemacs/declare-prefix "SPC o" "org")
  (spacemacs/set-leader-keys "`" 'ace-window
    "=" 'ace-window
    "SPC '" 'hackartist/ide/switch-or-create-other-frame
    "SPC ." 'helm-hackartist-buffer
    "SPC RET" 'yas-insert-snippet
    "SPC SPC" 'helm-mt
    "SPC TAB" 'counsel-semantic-or-imenu
    "SPC \\" 'apps/ide/toggle-input-method-custom
    "SPC bk" 'kill-this-buffer
    "SPC bu" 'revert-buffer
    "SPC ei" 'evil-insert
    "SPC gb" 'magit-branch-and-checkout
    "SPC gc" 'magit-branch-checkout
    "SPC gf" 'magit-fetch-all
    "SPC gl" 'magit-blame
    "SPC gr" 'magit-ediff-resolve
    "SPC hs" 'helm-slack
    "SPC ra" 'helm-all-mark-rings
    "SPC rk" 'helm-show-kill-ring
    "SPC rr" 'helm-mark-ring
    "SPC sc" 'sort-columns
    "SPC sf" 'sort-fields
    "SPC wm" 'maximize-window
    "SPC wn" 'minimize-window
    "SPC wb" 'balance-windows
    "SPC fo" 'hackartist/xdg-open)
  (define-key evil-normal-state-map (kbd "+") 'text-scale-increase)
  (define-key evil-normal-state-map (kbd "-") 'text-scale-decrease)
  (define-key evil-normal-state-map (kbd "=") 'text-scale-adjust)
  (define-key evil-normal-state-map (kbd ".") 'spacemacs/jump-to-definition)
  (define-key evil-normal-state-map (kbd ",") 'xref-pop-marker-stack)

  (hackartist/ide/org/bindings)
  (global-set-key (kbd "S-SPC") 'apps/ide/toggle-input-method-custom)
  (global-set-key (kbd "<home>") 'move-beginning-of-line)
  (global-set-key (kbd "<end>") 'move-end-of-line)
  (global-set-key (kbd "RET") 'newline-and-indent)
  (global-set-key (kbd "C-s") 'helm-swoop)
  (global-set-key (kbd "M-k") 'symbol-overlay-jump-prev)
  (global-set-key (kbd "M-j") 'symbol-overlay-jump-next)
  (add-hook 'vterm-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "p") 'term-paste)
              (define-key evil-normal-state-local-map (kbd "w") 'term-send-forward-word)
              (define-key evil-normal-state-local-map (kbd "b") 'term-send-backward-word)
              (define-key vterm-mode-map (kbd "C-s") 'helm-swoop)
              (define-key vterm-mode-map (kbd "M-h") 'term-send-backward-word)
              (define-key vterm-mode-map (kbd "M-l") 'term-send-forward-word)))
  (add-hook 'term-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "p") 'term-paste)
              ;; (define-key evil-normal-state-local-map (kbd "l") 'term-send-right)
              ;; (define-key evil-normal-state-local-map (kbd "h") 'term-send-left)
              ;; (define-key evil-normal-state-local-map (kbd "^") 'term-send-home)
              ;; (define-key evil-normal-state-local-map (kbd "$") 'term-send-end)
              (define-key evil-normal-state-local-map (kbd "w") 'term-send-forward-word)
              (define-key evil-normal-state-local-map (kbd "b") 'term-send-backward-word)
              (define-key term-mode-map (kbd "C-s") 'helm-swoop)
              (define-key term-mode-map (kbd "M-h") 'term-send-backward-word)
              (define-key term-mode-map (kbd "M-l") 'term-send-forward-word)))
  ;; (with-eval-after-load 'yasnippet
  ;;   (define-key yas-minor-mode-map (kbd "<s-return>") 'yas-insert-snippet))
  (add-hook 'company-mode-hook
            (lambda ()
              (interactive "")
              (define-key company-active-map (kbd "TAB") 'company-complete)
              (define-key company-active-map (kbd "ESC") 'company-abort)
              (define-key company-active-map (kbd "<return>") 'ide/company-active-return)
              (define-key company-active-map (kbd "<tab>") 'company-complete)))
  (with-eval-after-load 'helm
    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
    (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
    (define-key helm-map (kbd "C-z") 'helm-select-action) ; list actions using C-z

    ;; (global-set-key (kbd "M-x") 'counsel-M-x)
    ;; (global-set-key (kbd "M-x") 'helm-M-x)
    ;; (global-set-key (kbd "M-y") 'helm-show-kill-ring) ;
    (global-set-key (kbd "C-x b")
                    'helm-mini)
    (global-set-key (kbd "C-x C-f")
                    'helm-find-files)
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

(defun hackartist/ide/org/bindings ()
  "setting for org-hydra"
  (defhydra org-hydra
    (:color pink)
    "ORG hydra mode
"
    ("f" org-previous-visible-heading "previous visible heading")
    ("F" org-next-visible-heading "next visible heading")
    ("j" org-forward-heading-same-level "next same-level heading")
    ("k" org-backward-heading-same-level "previous same-level heading")
    ("h" outline-up-heading "go to parent heading")
    ("l" org-next-visible-heading "next visible heading")
    ("q" nil "quit" :color blue))
  (spacemacs/set-leader-keys-for-minor-mode
    'org-mode "." 'org-hydra/body)
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
              (define-key org-mode-map (kbd "RET") nil))))

