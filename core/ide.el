(defun hackartist//ide-setup ()
  (recentf-mode t)
  (display-line-numbers-mode t)
  (setq evil-respect-visual-line-mode t)
  (setq display-line-numbers 'relative)
  (use-package helm :bind (("C-x C-f" . helm-find-files)
			    ("M-x" . helm-M-x)))
  (use-package evil-collection :init (hackartist//ide-evil-init) :config (hackartist//ide-normal-key))
  (use-package evil-leader :config (global-evil-leader-mode))
  (use-package evil-surround :config (global-evil-surround-mode))
  (use-packate evil-indent-textobject)

  (use-package which-key :init (which-key-mode))
  (use-package doom-themes)
  (use-package helm-projectile :requires projectile :init (helm-projectile-on))
  (use-package helm-mt)
  (use-package ace-window)
  (use-package dap)
  (use-package lsp)
  (use-package magit)
  (use-package auto-package-update
    :config
    (setq auto-package-update-delete-old-versions t)
    (setq auto-package-update-hide-results t)
    (auto-package-update-maybe))

  (add-hook 'minibuffer-setup-hook
            (lambda ()
              (if (string= current-input-method 'korean-hangul)
                  (apps/ide/toggle-input-method-custom)
                (setq current-input-method nil)
                ))))

(defun hackartist//ide-evil-init()
  (setq evil-want-keybinding nil)
  (evil-collection-init)
  (evil-mode 1))

(defun hackartist//ide-normal-key ()
  (evil-define-key 'normal global-map (kbd "SPC SPC") 'helm-mt)
  (evil-define-key 'normal global-map (kbd "SPC `") 'ace-window)

  (evil-define-key 'normal global-map (kbd "SPC ff") 'helm-find-files)
  (evil-define-key 'normal global-map (kbd "SPC fr") 'helm-recentf)
  
  (evil-define-key 'normal global-map (kbd "SPC pf") 'helm-projectie-find-files)
  (evil-define-key 'normal global-map (kbd "SPC pp")  'helm-projectile-switch-project)

  (evil-define-key 'normal global-map (kbd "SPC wl")  'windmove-right)
  (evil-define-key 'normal global-map (kbd "SPC wh")  'windmove-left)
  (evil-define-key 'normal global-map (kbd "SPC wj")  'windmove-down)
  (evil-define-key 'normal global-map (kbd "SPC wk")  'windmove-up)
  (evil-define-key 'normal global-map (kbd "SPC ws")  'evil-window-split)
  (evil-define-key 'normal global-map (kbd "SPC w\\")  'evil-window-vsplit)
  (evil-define-key 'normal global-map (kbd "SPC wd")  'delete-window)
  (evil-define-key 'normal global-map (kbd "SPC w=")  'balance-windows)
  (evil-define-key 'normal global-map (kbd "SPC wm")  'maximize-window)

  (evil-define-key 'normal global-amp (kbd "SPC bk") 'kill-this-buffer)

  (evil-define-key 'normal global-map (kbd "+") 'text-scale-increase)
  (evil-define-key 'normal global-map (kbd "-") 'text-scale-decrease)
  (evil-define-key 'normal global-map (kbd "=") 'text-scale-adjust)
  (evil-define-key 'normal global-map (kbd ".") 'xref-find-definitions)
  (evil-define-key 'normal global-map (kbd ",") 'xref-pop-marker-stack)



  (evil-define-key 'normal global-map (kbd "SPC gs")  'magit-status)
 
  )

  
