(setq package-list '(
                     ;;common
                     magit
                     magit-popup
                     ;;setup-android
                     android-mode
                     ;; setup-tex
                     auctex
                     company-auctex
                     ;; setup-ecb
                     ecb
                     ;;setup-company
                     company
                     ;;setup-helm
                     popup
                     helm
                     helm-core
                     helm-swoop
                     ;;setup-helm-gtags
                     helm-gtags
                     ;;setup-projectile
                     pkg-info
                     projectile
                     helm-projectile
                     ;;setup-path
                     exec-path-from-shell
                     ;;setup-erlang
                     flycheck
                     flycheck-tip
                     company-distel
                     ;; setup-go
                     go-dlv
                     go-errcheck
                     go-guru
                     go-mode
                     go-playground
                     go-rename
                     gotest
                     company-go
                     ;;setup-fa
                     function-args
                     ;;setup-cedet
                     semantic
                     cc-mode
                     ;;setup-py
                     elpy
                     py-autopep8
                     ;;setup-jade
                     jade-mode
                     sws-mode
                     ;;setup-utree
                     undo-tree
                     ;;setup-markdown
                     markdown-mode
                     markdown-mode+
                     ;; setup-editing
                     anzu
                     dtrt-indent
                     yasnippet
                     volatile-highlights
                     clean-aindent-mode
                     ws-butler
                     iedit
                     duplicate-thing
                     ;;setup-yaml
                     yaml-mode
                     xcscope
                     )
      )

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "https://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(setq gc-cons-threshold 100000000)
(setq inhibit-startup-message t)

(defalias 'yes-or-no-p 'y-or-n-p)

(set-frame-parameter nil 'fullscreen 'fullboth)

(add-to-list 'load-path "~/.emacs.d/config")

(require 'setup-path)
(require 'setup-helm)
(require 'setup-helm-gtags)
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
(require 'setup-py)
(require 'setup-jade)
(require 'setup-go)
(require 'setup-erlang)
(require 'setup-tex)
(require 'setup-face)
(require 'setup-utree)
(require 'setup-c)
(require 'setup-yaml)
(require 'setup-android)
(require 'android)
(require 'setup-markdown)

;;(require 'setup-todo)
;; (require 'setup-ggtags)
;;(require 'setup-ac)
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

;;(global-linum-mode 1)


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
 '(android-mode-sdk-dir "/Volumes/Data/Developers/android")
 '(doc-view-continuous t)
 '(ecb-options-version "2.40")
 '(package-selected-packages
   (quote
    (ecb go-playground go-rename markdown-mode+ android-mode fixmee fixme-mode go-dlv company-go flymake flymake-yaml yaml-mode company-auctex auctex find-temp-file company-distel zygospore xcscope ws-butler volatile-highlights undo-tree tabbar-ruler sws-mode sr-speedbar smartparens py-autopep8 magit jedi jdee jade-mode iedit highlight-current-line helm-swoop helm-projectile helm-gtags go-guru go-errcheck go-autocomplete ggtags function-args flycheck-tip exec-path-from-shell emacs-eclim elpy ein duplicate-thing dtrt-indent company-jedi company-c-headers comment-dwim-2 clean-aindent-mode auto-complete-distel anzu))))

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white smoke" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "nil" :family "Menlo"))))
;;  '(mode-line-inactive ((t (:background "grey30" :foreground "grey80" :box (:line-width -1 :color "grey40") :weight light))))
;;  )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
