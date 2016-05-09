(require 'package)
;;(add-to-list 'package-archives
;;             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "https://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)
(setq gc-cons-threshold 100000000)
(setq inhibit-startup-message t)

(defalias 'yes-or-no-p 'y-or-n-p)


(add-to-list 'load-path "~/.emacs.d/config")

(require 'setup-helm)
(require 'setup-helm-gtags)
;; (require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)
(require 'setup-ecb)
(require 'setup-key)
(require 'setup-company)
(require 'xcscope)
(require 'setup-semantic)
(require 'setup-highlight-line)
(require 'setup-projectile)
(require 'setup-fa)
(require 'setup-eclim)
;;(require 'setup-ac)
(require 'setup-py)
(require 'setup-tramp)

(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

(setq make-backup-files nil)
(setq c-default-style "linux")
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq
 gdb-many-windows t
 gdb-show-main t
 )

(cua-mode 1)

(global-linum-mode 1)




(split-window-horizontally)



