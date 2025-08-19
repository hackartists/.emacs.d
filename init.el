(setq emacs-start-directory "~/.emacs.d")
;; (toggle-debug-on-error)
(let (res)
  (dolist (el (directory-files-recursively (concat emacs-start-directory "/core") ".*\.el$") res)
    (load-file el)))
;;(add-to-list 'package-archives '( "jcs-elpa" . "https://jcs-emacs.github.io/jcs-elpa/packages/") t)

(core/app/load-apps)
(setq spacemacs-start-directory "~/.emacs.d/spacemacs/")
(load-file (concat spacemacs-start-directory "init.el"))
(load-env-vars spacemacs-env-vars-file)
(core/app/init-apps)
(add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
;; (yas-reload-all)

;;(switch-to-buffer "*scratch*")

;; (set-frame-parameter nil 'fullscreen 'fullboth)

;; (setq ns-command-modifier 'super)
;; (server-start)
;; (split-window-horizontally)
;; (windmove-right)
;; (switch-to-buffer "*Messages*")
;; (windmove-left)
(put 'magit-clean 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-vc-selected-packages
   '((eat :url "https://codeberg.org/akib/emacs-eat" :branch "master")
     (claudemacs :url "https://github.com/cpoile/claudemacs.git"
		 :branch "main"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
