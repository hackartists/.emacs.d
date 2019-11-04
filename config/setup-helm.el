(use-package helm
  :requires ( popup helm-xref helm-mt helm-swoop helm-grags helm-ag helm-tramp)
  )
(use-package helm-projectile
  :ensure t
  :requires ( pkg-info projectile )
  :bind (
         :map projectile-mode-map
         ("C-c p g" . helm-projectile-grep)
         ("C-c p p" . helm-projectile-switch-project)
         ("C-c p f" . helm-projectile-find-file)
         ("C-c p k" . projectile-kill-buffers)
		 ("C-c p s" . projectile-save-project-buffers)
         )
  )

(use-package helm-mt
  :ensure t
  :bind
  ("C-t" . helm-mt))

(use-package helm-swoop
  :ensure t
  :config
  (setq helm-multi-swoop-edit-save t)
  (setq helm-swoop-split-with-multiple-windows t)
  (setq helm-swoop-split-direction 'split-window-vertically)
  (setq helm-swoop-speed-or-color t)
  :bind(("s-f" .  helm-swoop))
  )

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-set-key (kbd "C-c i") 'helm-imenu)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(define-key helm-grep-mode-map (kbd "<return>")  'helm-grep-mode-jump-other-window)
(define-key helm-grep-mode-map (kbd "n")  'helm-grep-mode-jump-other-window-forward)
(define-key helm-grep-mode-map (kbd "p")  'helm-grep-mode-jump-other-window-backward)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq
  helm-scroll-amount 4 ; scroll 4 lines other window using M-<next>/M-<prior>
  helm-ff-search-library-in-sexp t ; search for library in `require' and `declare-function' sexp.
  helm-split-window-in-side-p t ;; open helm buffer inside current window, not occupy whole other window
  helm-candidate-number-limit 500 ; limit the number of displayed canidates
  helm-ff-file-name-history-use-recentf t
  helm-move-to-line-cycle-in-source t ; move to end or beginning of source when reaching top or bottom of source.
  helm-buffers-fuzzy-matching t          ; fuzzy matching buffer names when non-nil
                                         ; useful in helm-mini that lists buffers

)

;;(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
;; (global-set-key (kbd "C-x r j") 'jump-to-register)

(define-key 'help-command (kbd "C-f") 'helm-apropos)
(define-key 'help-command (kbd "r") 'helm-info-emacs)
(define-key 'help-command (kbd "C-l") 'helm-locate-library)

;; use helm to list eshell history
(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map (kbd "M-l")  'helm-eshell-history)))

;;; Save current position to mark ring
(add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)

(define-key minibuffer-local-map (kbd "M-p") 'helm-minibuffer-history)
(define-key minibuffer-local-map (kbd "M-n") 'helm-minibuffer-history)
(define-key global-map [remap find-tag] 'helm-etags-select)
(define-key global-map [remap list-buffers] 'helm-buffers-list)

(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)

(helm-mode 1)

(define-key helm-map (kbd "<left>") 'helm-previous-source)
(define-key helm-map (kbd "<right>") 'helm-next-source)
(customize-set-variable 'helm-ff-lynx-style-map t)
(customize-set-variable 'helm-imenu-lynx-style-map t)
(customize-set-variable 'helm-semantic-lynx-style-map t)
(customize-set-variable 'helm-occur-use-ioccur-style-keys t)
(customize-set-variable 'helm-grep-use-ioccur-style-keys t)

(provide 'setup-helm)
