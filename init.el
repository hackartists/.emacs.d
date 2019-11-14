(setq spacemacs-start-directory "~/.emacs.d/spacemacs/")
(load-file (concat spacemacs-start-directory "init.el"))

(defalias 'yes-or-no-p 'y-or-n-p)
(switch-to-buffer "*scratch*")

(add-to-list 'load-path "~/.emacs.d/config")
(add-to-list 'load-path "~/.emacs.d/refs/jdibug")
(set-frame-parameter nil 'fullscreen 'fullboth)
(global-git-gutter+-mode nil)
(flyspell-mode-off)

(require 'setup-docker)
(require 'setup-path)
(require 'setup-helm)
(require 'setup-editing)
(require 'setup-key)
(require 'setup-company)
(require 'setup-projectile)
(require 'setup-go)
(require 'setup-java)

(setq warning-minimum-level :emergency)
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

(setq make-backup-files nil)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq
 gdb-many-windows t
 gdb-show-main t
 )

(cua-mode 1)
(server-start)
(split-window-horizontally)
(windmove-right)
(switch-to-buffer "*Messages*")
(clm/toggle-command-log-buffer)
(global-command-log-mode)
(windmove-left)
