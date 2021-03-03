(defun hackartist//ide-setup ()
  (recentf-mode t)

  (defalias 'yes-or-no-p 'y-or-n-p)
  (setq make-backup-files nil)
  (setq auto-save-default nil)
  (setq evil-respect-visual-line-mode t)
  (setq display-line-numbers-type 'relative)
  (global-display-line-numbers-mode t)
  (use-package helm :init (setq helm-default-display-buffer-functions '(display-buffer-in-side-window))
    :bind (("C-x C-f" . helm-find-files)
			   ("M-x" . helm-M-x)
			   :map helm-map
			   ("TAB" . helm-execute-persistent-action)))
  (use-package evil-collection :init (hackartist//ide-evil-init) :config (hackartist//ide-normal-key))
  (use-package evil-leader :config (global-evil-leader-mode))
  (use-package evil-surround :config (global-evil-surround-mode))
  (use-package evil-indent-textobject)

  (use-package which-key :init (which-key-mode))
  (use-package doom-themes)
  (use-package helm-projectile :requires projectile :init (helm-projectile-on) :config (hackartist//ide-projectile-setup))
  (use-package helm-mt)
  (use-package ace-window)
  (use-package dap-mode)
  (use-package lsp-mode)
  (use-package magit)
  (use-package helm-swoop)
(use-package edit-server
  :if window-system
  :init
  (add-hook 'after-init-hook 'server-start t)
  (add-hook 'after-init-hook 'edit-server-start t))
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :config
  (exec-path-from-shell-initialize))
  (use-package company :init (global-company-mode t) :config (hackartist//ide-company-setup)
    :bind (
	   :map company-active-map
	  ("TAB" . 'company-complete)
	  ("ESC" . 'company-abort)
	  ("RET" . 'ide/company-active-return)))
  (use-package auto-package-update
    :config
    (setq auto-package-update-delete-old-versions t)
    (setq auto-package-update-hide-results t)
    (auto-package-update-maybe))

  (hackartist//ide-advice)
  (add-hook 'minibuffer-setup-hook
            (lambda ()
              (if (string= current-input-method 'korean-hangul)
                  (apps/ide/toggle-input-method-custom)
                (setq current-input-method nil)
                )))

    (hackartist//helm-commands)
  )

(defun hackartist//helm-commands ()
  (setq helm-hackartist-buffers-list (make-hackartist-helm-source (helm-make-source "Buffers" 'helm-source-buffers)))
  (helm-projectile-on)
  (setq helm-hackartist-projectile-files-list (make-hackartist-helm-source helm-source-projectile-files-list)))
(defun hackartist//ide-evil-init()
  (setq evil-want-keybinding nil)
  (evil-collection-init)
  (evil-mode 1))

(defun hackartist//ide-normal-key ()
  (evil-define-key 'normal global-map (kbd "SPC SPC") 'helm-mt)
  (evil-define-key 'normal global-map (kbd "SPC TAB") 'helm-imenu)
  (evil-define-key 'normal global-map (kbd "SPC `") 'ace-window)
  (evil-define-key 'normal global-map (kbd "SPC .") 'helm-hackartist-buffer)


  (evil-define-key 'normal global-map (kbd "SPC ff") 'helm-find-files)
  (evil-define-key 'normal global-map (kbd "SPC fr") 'helm-recentf)
  
  (evil-define-key 'normal global-map (kbd "SPC pf") 'helm-projectie-find-file)
  (evil-define-key 'normal global-map (kbd "SPC pp")  'helm-projectile-switch-project)

  (evil-define-key 'normal global-map (kbd "SPC wl")  'windmove-right)
  (evil-define-key 'normal global-map (kbd "SPC wh")  'windmove-left)
  (evil-define-key 'normal global-map (kbd "SPC wj")  'windmove-down)
  (evil-define-key 'normal global-map (kbd "SPC wk")  'windmove-up)
  (evil-define-key 'normal global-map (kbd "SPC ws")  'evil-window-split)
  (evil-define-key 'normal global-map (kbd "SPC w/")  'evil-window-vsplit)
  (evil-define-key 'normal global-map (kbd "SPC wd")  'delete-window)
  (evil-define-key 'normal global-map (kbd "SPC w=")  'balance-windows)
  (evil-define-key 'normal global-map (kbd "SPC wm")  'maximize-window)



  (evil-define-key 'normal global-map (kbd "SPC bk") 'kill-this-buffer)
  (evil-define-key 'normal global-map (kbd "SPC bu") 'revert-buffer)

  (evil-define-key 'normal global-map (kbd "C-u")  'evil-scroll-page-up)
  (evil-define-key 'normal global-map (kbd "C-d")  'evil-scroll-page-down)
  (evil-define-key 'normal global-map (kbd "+") 'text-scale-increase)
  (evil-define-key 'normal global-map (kbd "-") 'text-scale-decrease)
  (evil-define-key 'normal global-map (kbd "=") 'text-scale-adjust)
  (evil-define-key 'normal global-map (kbd ".") 'xref-find-definitions)
  (evil-define-key 'normal global-map (kbd ",") 'xref-pop-marker-stack)

  (evil-define-key 'normal global-map (kbd "SPC sgp") 'helm-projectile-grep)
  (evil-define-key 'normal global-map (kbd "SPC ss")  'helm-swoop)
  
  (evil-define-key 'normal global-map (kbd "SPC gs")  'magit-status)
  (evil-define-key 'normal global-map (kbd "SPC gb")  'magit-branch-and-checkout)
  (evil-define-key 'normal global-map (kbd "SPC gc")  'magit-branch-checkout)
 
  )

(defun hackartist//ide-advice ()
  (advice-add 'windmove-do-window-select :after #'balance-windows))

(defun hackartist//ide-global-key ()
  (global-set-key (kbd "S-SPC") 'apps/ide/toggle-input-method-custom)
  (global-set-key (kbd "<home>") 'move-beginning-of-line)
  (global-set-key (kbd "<end>") 'move-end-of-line)
  (global-set-key (kbd "RET") 'newline-and-indent)
  (global-set-key (kbd "M-k") 'symbol-overlay-jump-prev)
  (global-set-key (kbd "M-j") 'symbol-overlay-jump-next)
  )

(defun ide/company-active-return ()
  (interactive)
  (company-abort)
  (newline-and-indent))

(defun hackartist/xdg-open ()
  (interactive)
  (shell-command "xdg-open ."))

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



(defun hackartist//ide-projectile-setup ()
  (setq projectile-completion-system 'helm)
  (setq projectile-indexing-method 'alien)
  (setq projectile-git-submodule-command nil)
  (setq projectile-project-root-files '("rebar.config" "project.clj" "build.boot"
                                        "SConstruct" "pom.xml" "build.sbt" "gradlew"
                                        "build.gradle" ".ensime" "Gemfile" "requirements.txt"
                                        "setup.py" "tox.ini" "composer.json" "Cargo.toml"
                                        "mix.exs" "stack.yaml" "info.rkt" "DESCRIPTION"
                                        "TAGS" "GTAGS" ".dropbox" ".projectile"))
  )

(defun hackartist//ide-company-setup ()
  (setq company-idle-delay 0)
  (setq company-require-match nil)
  (setq company-lsp-cache-candidates t))
