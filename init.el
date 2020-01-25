(setq spacemacs-start-directory "~/.emacs.d/spacemacs/")
(load-file (concat spacemacs-start-directory "init.el"))

(defalias 'yes-or-no-p 'y-or-n-p)
(switch-to-buffer "*scratch*")

(add-to-list 'load-path "~/.emacs.d/config")
(add-to-list 'load-path "~/.emacs.d/refs/jdibug")
(add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
(set-frame-parameter nil 'fullscreen 'fullboth)

(require 'setup-docker)
(require 'setup-path)
(require 'setup-helm)
(require 'setup-editing)
(require 'setup-key)
(require 'setup-company)
(require 'setup-projectile)
(require 'setup-go)
(require 'setup-java)

(setq
 gdb-many-windows t
 gdb-show-main t
 )

(setq ns-command-modifier 'super)
(global-set-key (kbd "S-SPC") 'toggle-input-method-custom)
(cua-mode 1)
(server-start)
(split-window-horizontally)
(windmove-right)
(switch-to-buffer "*Messages*")
(clm/toggle-command-log-buffer)
(global-command-log-mode)
(windmove-left)
