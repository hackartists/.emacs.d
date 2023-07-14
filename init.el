(setq emacs-start-directory "~/.emacs.d")
;; (toggle-debug-on-error)
(let (res)
  (dolist (el (directory-files-recursively (concat emacs-start-directory "/core") ".*\.el$") res)
    (load-file el)))

(core/app/load-apps)

(setq spacemacs-start-directory "~/.emacs.d/spacemacs/")
(load-file (concat spacemacs-start-directory "init.el"))
(load-env-vars spacemacs-env-vars-file)
(core/app/init-apps)
(add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
(yas-reload-all)

;;(switch-to-buffer "*scratch*")

;; (set-frame-parameter nil 'fullscreen 'fullboth)

;; (setq ns-command-modifier 'super)
;; (server-start)
;; (split-window-horizontally)
;; (windmove-right)
;; (switch-to-buffer "*Messages*")
;; (windmove-left)
(put 'magit-clean 'disabled nil)
