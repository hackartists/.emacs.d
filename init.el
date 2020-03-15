(setq emacs-start-directory "~/.emacs.d")

(let (res)
  (dolist (el (directory-files-recursively (concat emacs-start-directory "/core") ".*\.el$") res)
    (load-file el)))

(core/app/load-apps)

(setq spacemacs-start-directory "~/.emacs.d/spacemacs/")
(load-file (concat spacemacs-start-directory "init.el"))
(core/app/init-apps)

(switch-to-buffer "*scratch*")

;; (load-file "~/.emacs.d/private/slack.el")
(add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
(set-frame-parameter nil 'fullscreen 'fullboth)

(setq ns-command-modifier 'super)
(server-start)
(split-window-horizontally)
(windmove-right)
(switch-to-buffer "*Messages*")
(windmove-left)
;; (slack-start)
