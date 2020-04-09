(setq make-backup-files nil)
(setq auto-save-default nil)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq hackartist-configuration-layers '())

(add-hook 'focus-out-hook (lambda ()
			    (interactive)
			    (save-some-buffers t )
			    ))

(add-hook 'configuration-layer-pre-load-hook
          (lambda ()
            (advice-add 'dotspacemacs/layers :after #'hackartist//config-load)
            (advice-add 'dotspacemacs/init :after #'hackartist//layer-init)
            ;; (dolist (el hackartist-configuration-layers) (dotspacemacs/add-layer el))
            ;; (dolist (el hackartist-apps) (hackartist//app-config el))
            ))

(defun hackartist//config-load ()
  (setq dotspacemacs-configuration-layers '())
  (setq dotspacemacs-themes '(twilight))
  (dolist (el hackartist-packages) (add-to-list 'dotspacemacs-additional-packages el))
  (dolist (el hackartist-configuration-layers) (add-to-list 'dotspacemacs-configuration-layers el)))

(defun hackartist//load-app-config (app)
  (let ((config (intern (concat "hackartist/" (concat app "/config")))))
    (condition-case nil (funcall config) (error (concat (symbol-name config) " function does notnpm install import-js -g defined")))))


(defun hackartist//layer-init ()
  (setq dotspacemacs-startup-banner nil)
  ;; (setq dotspacemacs-pretty-docs t)
  )
