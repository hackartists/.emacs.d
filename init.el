(setq package-archives '(
                         ("melpa" . "https://melpa.org/packages/")
			 ("gnu" . "https://elpa.gnu.org/packages/")))
(defalias 'yes-or-no-p 'y-or-n-p)
(set-frame-parameter nil 'fullscreen 'fullboth)

(package-initialize)
(package-refresh-contents)
(setq emacs-start-directory "~/.emacs.d")

;; (directory-files-recursively (concat emacs-start-directory "/core") ".*\.el$")
;; (directory-files-recursively (concat emacs-start-directory "/apps") ".*\.el$")

(let (res)
  (dolist (el (append (directory-files-recursively (concat emacs-start-directory "/core") ".*\.el$")
		      (directory-files-recursively (concat emacs-start-directory "/apps") ".*\.el$"))
	      res)	      
    (load-file el)))

(switch-to-buffer "*scratch*")

(add-to-list 'load-path "~/.emacs.d/config")
(add-to-list 'load-path "~/.emacs.d/refs/jdibug")
;; (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")

;; (require 'setup-docker)
;; (require 'setup-path)
;; (require 'setup-helm)
;; (require 'setup-editing)
;; (require 'setup-key)
;; (require 'setup-company)
;; (require 'setup-projectile)
;; (require 'setup-go)
;; (require 'setup-java)

(setq
 gdb-many-windows t
 gdb-show-main t
 )

;; (global-set-key (kbd "S-SPC") 'toggle-input-method-custom)
(split-window-horizontally)
(windmove-right)
(switch-to-buffer "*Messages*")
(windmove-left)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default))
 '(package-selected-packages
   '(spacemacs-theme popup helm go-mode company yasnippet popwin helm-tramp helm-swoop helm-projectile helm-mt helm-gtags helm-ag godoctor go-tag go-rename go-impl go-guru go-gen-test go-fill-struct go-eldoc ggtags flycheck counsel-gtags company-go command-log-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
