
;; (defalias 'yes-or-no-p 'y-or-n-p)
;; (set-frame-parameter nil 'fullscreen 'fullboth)

;; (setq emacs-start-directory "~/.emacs.d")

;; (let (res)
;;   (dolist (el (directory-files-recursively (concat emacs-start-directory "/core") ".*\.el$") res)	      
;;     (load-file el)))

;; (core/app/load-apps)
;; (core/ui/init)
;; ;; (add-to-list 'load-path "~/.emacs.d/config")
;; ;; (add-to-list 'load-path "~/.emacs.d/refs/jdibug")
;; ;; (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")

;; ;; (require 'setup-docker)
;; ;; (require 'setup-path)
;; ;; (require 'setup-helm)
;; ;; (require 'setup-editing)
;; ;; (require 'setup-key)
;; ;; (require 'setup-company)
;; ;; (require 'setup-projectile)
;; ;; (require 'setup-go)
;; ;; (require 'setup-java)

;; (setq
;;  gdb-many-windows t
;;  gdb-show-main t
;;  )

;; ;; (global-set-key (kbd "S-SPC") 'toggle-input-method-custom)

;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(custom-safe-themes
;;    (quote
;;     ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
;;  '(helm-ff-lynx-style-map t)
;;  '(helm-grep-use-ioccur-style-keys t)
;;  '(helm-imenu-lynx-style-map t t)
;;  '(helm-occur-use-ioccur-style-keys t)
;;  '(helm-semantic-lynx-style-map t t)
;;  '(package-selected-packages
;;    (quote
;;     (inf-mongo mongo reveal-in-osx-finder minibuffer-complete-cycle go-snippets go-imports go-imenu go-dlv go-add-tags go-playground yasnippet-snippets pylookup))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )

(setq spacemacs-start-directory "~/.emacs.d/spacemacs/")
(load-file (concat spacemacs-start-directory "init.el"))

(defalias 'yes-or-no-p 'y-or-n-p)
(switch-to-buffer "*scratch*")

(add-to-list 'load-path "~/.emacs.d/config")
;; (add-to-list 'load-path "~/.emacs.d/refs/jdibug")
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

;; (setq
;;  gdb-many-windows t
;;  gdb-show-main t
;;  )

;; (setq ns-command-modifier 'super)
(global-set-key (kbd "S-SPC") 'toggle-input-method-custom)
(cua-mode 1)
(server-start)
(split-window-horizontally)
(windmove-right)
(switch-to-buffer "*Messages*")
(clm/toggle-command-log-buffer)
(global-command-log-mode)
(windmove-left)
