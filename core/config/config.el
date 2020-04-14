(setq make-backup-files nil)
(setq auto-save-default nil)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq hackartist-configuration-layers '())

(advice-add 'dotspacemacs/init :after #'hackartist//layer-init)
(advice-add 'dotspacemacs/layers :after #'hackartist//config-load)

(add-hook 'focus-out-hook (lambda ()
			    (interactive)
			    (save-some-buffers t )
			    ))

;; (add-hook 'configuration-layer-pre-load-hook
;;           (lambda ()
            
;;             ;; (dolist (el hackartist-configuration-layers) (dotspacemacs/add-layer el))
;;             ;; (dolist (el hackartist-apps) (hackartist//app-config el))
;;             ))

(defun hackartist//config-load ()
  (setq dotspacemacs-configuration-layers '())
  (setq dotspacemacs-themes '(darktooth))
  (dolist (el hackartist-packages) (add-to-list 'dotspacemacs-additional-packages el))
  (dolist (el hackartist-configuration-layers) (add-to-list 'dotspacemacs-configuration-layers el)))

(defun hackartist//load-app-config (app)
  (let ((config (intern (concat "hackartist/" (concat app "/config")))))
    (condition-case nil (funcall config) (error (concat (symbol-name config) " function does notnpm install import-js -g defined")))))


(defun hackartist//layer-init ()
  (setq
   dotspacemacs-startup-banner nil
   dotspacemacs-enable-server t
   dotspacemacs-pretty-docs t
   dotspacemacs-loading-progress-bar t
   dotspacemacs-mode-line-theme '(doom :separator wave :separator-scale 1.5)
   doom-modeline-github t
   doom-modeline-irc-buffers t
   doom-modeline-unicode-fallback t
   doom-modeline-vcs-max-length 30))
