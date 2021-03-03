(setq emacs-start-directory "~/.emacs.d")
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(package-install 'use-package)

(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(let (res)
  (dolist (el (directory-files-recursively (concat emacs-start-directory "/core") ".*\.el$") res)
    (load-file el))
  (dolist (el (directory-files-recursively (concat emacs-start-directory "/modes") ".*\.el$") res)
    (load-file el)))
(hackartist//ide-setup)
(set-frame-parameter nil 'fullscreen 'fullboth)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(doom-dracula))
 '(custom-safe-themes
   '("e6ff132edb1bfa0645e2ba032c44ce94a3bd3c15e3929cdf6c049802cf059a2a" default))
 '(helm-minibuffer-history-key "M-p")
 '(helm-mode t)
 '(package-selected-packages
   '(helm-imenu dap-mode magit window-number window-numbering ace-window helm-mt evil-surround evil-indent-textobject evil-leader helm-projectile helm-projectil doom-themes company-mode which-key use-package lsp-mode helm go-mode evil-collection company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#282a36" :foreground "#f8f8f2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 175 :width normal :foundry "RIXF" :family "D2Coding")))))
