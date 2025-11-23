(defun ide/company-active-return ()
  (interactive)
  (company-abort)
  (newline-and-indent))

(defun hackartist/xdg-open ()
  (interactive)
  (shell-command "xdg-open ."))

(defun hackartist/ide/bindings ()
  (spacemacs/declare-prefix "TAB" "Imenu")
  (spacemacs/declare-prefix "'" "create a snippet")
  (spacemacs/declare-prefix "gT" "tag")

  (spacemacs/set-leader-keys-for-major-mode 'plantuml-mode
    "SPC" 'plantuml-preview
    )

  (spacemacs/set-leader-keys-for-minor-mode 'lsp-mode
    "SPC" 'gptel-menu
    )

  (spacemacs/set-leader-keys
    "`" 'ace-window
    "=" 'ace-window
    "'" 'hackartist/ide/switch-or-create-other-frame
    "." 'helm-hackartist-buffer
    "'" 'helm-yas-create-snippet-on-region

    "RET" 'yas-insert-snippet
    "SPC" 'helm-mt
    "TAB" 'helm-imenu

    "bk" 'kill-this-buffer
    "bu" 'revert-buffer

    "gd" 'helm-magit-todos
    "gn" 'github-notifier-visit-github
    "gw" 'magit-worktree
    "gB" 'magit-branch-and-checkout
    "gC" 'magit-branch-checkout
    "gF" 'magit-fetch-all
    "gTc" 'magit-tag-create
    "gTd" 'magit-tag-delete
    "gTr" 'magit-tag-release
    "gTp" 'magit-push-tag

    "pF" 'projectile-find-file-other-window

    "wn" 'minimize-window

    "fO" 'hackartist/xdg-open
    "f." 'treemacs-display-current-project-exclusively
    "ff" 'spacemacs/helm-find-files

    "ss" 'helm-swoop


    "rM" 'helm-global-mark-ring

    "sgP" 'counsel-git-grep

    "xf RET" 'ox-clip-formatted-copy)

  (spacemacs/declare-prefix-for-mode 'prog-mode "l" "lsp")
  (spacemacs/set-leader-keys-for-minor-mode 'prog-mode
    "l RET" 'lsp-avy-lens)

  (spacemacs/set-leader-keys-for-minor-mode 'term-mode
    "xo" 'browse-url-at-point)

  (spacemacs/declare-prefix-for-mode 'term-mode "x" "text")
  (spacemacs/set-leader-keys-for-minor-mode 'term-mode
    "xo" 'browse-url-at-point)

  (spacemacs/set-leader-keys-for-major-mode 'forge-topic-mode
    "RET" 'code-review-forge-pr-at-point)

  (spacemacs/declare-prefix "B" "Bookmarks")
  (spacemacs/declare-prefix "P" "pass")
  (spacemacs/declare-prefix "Po" "otp")
  (spacemacs/set-leader-keys
    "B." 'helm-bookmarks
    "Bb" 'bookmark-set

    "P." 'helm-pass

    "Py" 'password-store-copy
    "Pg" 'password-store-generate
    "Pi" 'password-store-insert
    "Pc" 'password-store-edit
    "Pr" 'password-store-rename
    "Pd" 'password-store-remove
    "PD" 'password-store-clear
    "PI" 'password-store-init
    "Pw" 'password-store-url
    "P?" 'spacemacs/pass-describe
    "PY" 'spacemacs/pass-copy-and-describe

    "Poy" 'password-store-otp-token-copy
    "PoY" 'password-store-otp-uri-copy
    "Poi" 'password-store-otp-insert
    "Poa" 'password-store-otp-append
    "PoA" 'password-store-otp-append-from-image)


  (evil-define-key 'motion dictionary-mode-map "." 'dictionary-lookup-definition)
  (evil-define-key 'motion dictionary-mode-map "," 'dictionary-previous)

  (define-key evil-normal-state-map (kbd "+") 'text-scale-increase)
  (define-key evil-normal-state-map (kbd "-") 'text-scale-decrease)
  (define-key evil-normal-state-map (kbd "=") 'text-scale-adjust)
  (define-key evil-normal-state-map (kbd ".") 'spacemacs/jump-to-definition)
  (define-key evil-normal-state-map (kbd ",") 'xref-pop-marker-stack)

  (global-set-key (kbd "S-SPC") 'apps/ide/toggle-input-method-custom)
  ;; (global-set-key (kbd "S-SPC") 'toggle-input-method)
  (global-set-key (kbd "<home>") 'move-beginning-of-line)
  (global-set-key (kbd "<end>") 'move-end-of-line)
  ;; (global-set-key (kbd "RET") 'newline-and-indent)
  (global-set-key (kbd "C-s") 'helm-swoop)
  (global-set-key (kbd "M-k") 'symbol-overlay-jump-prev)
  (global-set-key (kbd "M-j") 'symbol-overlay-jump-next)
  ;; (add-hook 'vterm-mode-hook
  ;;           (lambda ()
  ;;             (define-key evil-normal-state-local-map (kbd "p") 'term-paste)
  ;;             (define-key evil-normal-state-local-map (kbd "w") 'term-send-forward-word)
  ;;             (define-key evil-normal-state-local-map (kbd "b") 'term-send-backward-word)
  ;;             (define-key vterm-mode-map (kbd "C-s") 'helm-swoop)
  ;;             (define-key vterm-mode-map (kbd "M-h") 'term-send-backward-word)
  ;;             (define-key vterm-mode-map (kbd "M-l") 'term-send-forward-word)))
  (add-hook 'term-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "p") 'term-paste)
              ;; (define-key evil-normal-state-local-map (kbd "l") 'term-send-right)
              ;; (define-key evil-normal-state-local-map (kbd "h") 'term-send-left)
              ;; (define-key evil-normal-state-local-map (kbd "^") 'term-send-home)
              ;; (define-key evil-normal-state-local-map (kbd "$") 'term-send-end)
              ;; (define-key evil-normal-state-local-map (kbd "w") 'term-send-forward-word)
              ;; (define-key evil-normal-state-local-map (kbd "b") 'term-send-backward-word)
              (define-key term-mode-map (kbd "C-s") 'helm-swoop)
              (define-key term-mode-map (kbd "M-h") 'term-send-backward-word)
              (define-key term-mode-map (kbd "M-l") 'term-send-forward-word)))

  (with-eval-after-load 'company
    (define-key company-active-map (kbd "ESC") 'company-abort)
    ;; (define-key company-active-map (kbd "<return>") 'ide/company-active-return)
    (define-key company-active-map (kbd "<tab>") 'company-complete)
    ;; (delq 'company-preview-if-just-one-frontend company-frontends)
    )

  ;; (add-hook 'company-mode-hook
  ;;           (lambda ()
  ;;(define-key company-active-map (kbd "ESC") 'company-abort)
  ;; (define-key company-active-map (kbd "<return>") 'ide/company-active-return)
  ;; (define-key company-active-map (kbd "<tab>") 'company-complete)))
  ;; (with-eval-after-load 'yasnippet
  ;;   (define-key yas-minor-mode-map [(tab)]       (yas-filtered-definition 'yas-next-field))
  ;;   (define-key yas-minor-mode-map (kbd "TAB")   (yas-filtered-definition 'yas-next-field)))
  ;; (ide/keyboard-dvorak)

  (with-eval-after-load 'helm
    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
    ;; (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
    ;; (define-key helm-map (kbd "C-z") 'helm-select-action) ; list actions using C-z

    ;; (global-set-key (kbd "C-x b") 'helm-mini)
    ;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
    ;; (define-key 'help-command (kbd "C-f") 'helm-apropos)
    ;; (define-key 'help-command (kbd "r") 'helm-info-emacs)
    ;; (define-key 'help-command (kbd "C-l") 'helm-locate-library)
    (add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)
    (define-key minibuffer-local-map (kbd "M-p") 'helm-minibuffer-history)
    (define-key minibuffer-local-map (kbd "M-n") 'helm-minibuffer-history)
    ;;(define-key global-map [remap find-tag] 'helm-etags-select)
    ;;(define-key global-map [remap list-buffers] 'helm-buffers-list)
    (setq helm-ff-DEL-up-one-level-maybe t)
    ;; (define-key helm-find-files-map (kbd "<backspace>") 'helm-find-files-up-one-level)
    (define-key helm-map (kbd "<left>") 'helm-previous-source)
    (define-key helm-map (kbd "<right>") 'helm-next-source)))

(defun hackartist/hybrid-completion-tab ()
  (interactive)
  (or
   (copilot-accept-completion)
   (company-complete) ;(company-complete-selection)
   (indent-for-tab-command)))
