
;; (defalias 'yes-or-no-p 'y-or-n-p)
;; (set-frame-parameter nil 'fullscreen 'fullboth)

;; (setq emacs-start-directory "~/.emacs.d")

;; (let (res)
;;   (dolist (el (directory-files-recursively (concat emacs-start-directory "/core") ".*\.el$") res)	      
;;     (load-file el)))

;; (core/app/load-apps)
;; (core/ui/init)


(setq spacemacs-start-directory "~/.emacs.d/spacemacs/")
(load-file (concat spacemacs-start-directory "init.el"))

(defalias 'yes-or-no-p 'y-or-n-p)
(switch-to-buffer "*scratch*")

(add-to-list 'load-path "~/.emacs.d/config")
;; (load-file "~/.emacs.d/private/slack.el")
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

(setq ns-command-modifier 'super)
(global-set-key (kbd "S-SPC") 'toggle-input-method-custom)
(cua-mode 1)
(server-start)
(split-window-horizontally)
(windmove-right)
(switch-to-buffer "*Messages*")
(windmove-left)
;; (slack-start)
