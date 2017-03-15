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
(require 'setup-jade)
(require 'setup-go)
(require 'setup-erlang)
;;(require 'setup-smartparens)
;;(require 'setup-font)

(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

(setq make-backup-files nil)
(setq c-default-style "bsd")
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq
 gdb-many-windows t
 gdb-show-main t
 )

(cua-mode 1)

(global-linum-mode 1)




(split-window-horizontally)



;;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; '(ecb-options-version "2.40")
;; '(ecb-source-path
;;   (quote
;;    ("/sshx:hackartist@lab.artofthings.org#10022:" "lab"))))

;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;'(highlight-current-line-face ((t (:background "yellow15" :height 400 :family "Nanum Gothic")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(package-selected-packages
   (quote
    (company-distel zygospore xcscope ws-butler volatile-highlights undo-tree tabbar-ruler sws-mode sr-speedbar smartparens py-autopep8 magit jedi jdee jade-mode iedit highlight-current-line helm-swoop helm-projectile helm-gtags go-guru go-errcheck go-autocomplete ggtags function-args flycheck-tip exec-path-from-shell emacs-eclim elpy ein ecb duplicate-thing dtrt-indent company-jedi company-c-headers comment-dwim-2 clean-aindent-mode auto-complete-distel anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
