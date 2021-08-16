(setq make-backup-files nil)
(setq auto-save-default nil)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq hackartist-configuration-layers '())
(setq helm-split-window-inside-p t)

(advice-add 'dotspacemacs/init :after #'hackartist//layer-init)
(advice-add 'dotspacemacs/layers :after #'hackartist//config-load)
(advice-add 'spacemacs-buffer//insert-version :before #'hackartist//version)
(advice-add 'spacemacs-buffer//insert-version :after #'hackartist//restore)
(advice-add 'spacemacs/init :before #'hackartist//init)

(add-hook 'focus-out-hook (lambda ()
			    (interactive)
			    (save-some-buffers t )
			    ))

;; (add-hook 'configuration-layer-pre-load-hook
;;           (lambda ()
;;             ;; (dolist (el hackartist-configuration-layers) (dotspacemacs/add-layer el))
;;             ;; (dolist (el hackartist-apps) (hackartist//app-config el))
;;             ))
(defun hackartist//init ()
  (defconst spacemacs-buffer-name "*hackartist-emacs*")
  (defconst spacemacs-buffer-logo-title "[H A C K A R T I S T - E M A C S]")
  )
(defun hackartist//version ()
  (setq dotspacemacs-distribution 'hackartist-emacs))

(defun hackartist//restore ()
  (setq dotspacemacs-distribution 'spacemacs))

(defun hackartist//config-load ()
  (add-to-list 'dotspacemacs-configuration-layer-path (concat emacs-start-directory "/adapters/"))
  (setq dotspacemacs-configuration-layers '())
  (setq dotspacemacs-themes '(darktooth))
  (dolist (el hackartist-packages) (add-to-list 'dotspacemacs-additional-packages el))
  (dolist (el hackartist-configuration-layers) (add-to-list 'dotspacemacs-configuration-layers el)))

(defun hackartist//load-app-config (app)
  (let ((config (intern (concat "hackartist/" (concat app "/config")))))
    (condition-case nil (funcall config) (error (concat (symbol-name config) " function does notnpm install import-js -g defined")))))


(defun hackartist//layer-init ()
  (setq
   dotspacemacs-line-numbers 'relative
   ;;dotspacemacs-startup-banner nil
   dotspacemacs-enable-server t
   dotspacemacs-pretty-docs t
   dotspacemacs-major-mode-leader-key "RET"
   dotspacemacs-loading-progress-bar t
   dotspacemacs-mode-line-theme '(doom :separator wave :separator-scale 1.5)
   ;; dotspacemacs-startup-lists '((recents  . 5)
   ;;                              (projects . 15)
   ;;                              (todos . 5)
   ;;                              (bookmarks . 5))
   dotspacemacs-startup-lists '((recents  . 5)
                                (projects . 3)
                                (todos . 3)
                                (bookmarks . 3))

   doom-modeline-github t
   doom-modeline-irc-buffers t
   doom-modeline-unicode-fallback t
   doom-modeline-vcs-max-length 30
   dotspacemacs-default-font '("D2Coding"
                               :size 14.0
                               :weight normal
                               :width normal)
   dotspacemacs-emacs-command-key "X")

  ;; (let ((ret '()))
  ;;   (dolist
  ;;       (el spacemacs/key-binding-prefixes)
  ;;     (if (not (string= (car el) "SPC"))
  ;;         (push el ret)))
  ;;   (setq spacemacs/key-binding-prefixes ret))
  )
