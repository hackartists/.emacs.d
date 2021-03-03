(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)
(use-package helm :bind (("C-x C-f" . helm-find-files)
				   ("M-x" . helm-M-x)))
(use-package company)
(use-package go-mode)
(use-package org)
(use-package lsp-mode)
(use-package evil-collection :commands (evil-mode evil-define-key))
(use-package evil-leader :config (global-evil-leader-mode))
(use-package evil-surround :config (global-evil-surround-mode))
(use-package evil-indent-textobject)

(use-package which-key :init (which-key-mode))
(use-package doom-themes :init (doom-modeline-mode))
(use-package helm-projectile :requires projectile :init (helm-projectile-on))
(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(doom-dracula))
 '(custom-safe-themes
   '("e6ff132edb1bfa0645e2ba032c44ce94a3bd3c15e3929cdf6c049802cf059a2a" default))
 '(helm-mode t)
 '(package-selected-packages
   '(evil-surround evil-indent-textobject evil-leader helm-projectile helm-projectil doom-themes company-mode which-key use-package lsp-mode helm go-mode evil-collection company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#282a36" :foreground "#f8f8f2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 175 :width normal :foundry "RIXF" :family "D2Coding")))))
