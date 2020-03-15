(setq make-backup-files nil)
(setq auto-save-default nil)
(defalias 'yes-or-no-p 'y-or-n-p)

(defvar hackartist-config-pre-load-hook nil
  "Hook executed at the beginning of configuration loading.")

(setq dotspacemacs-configuration-layers '())

(defun hackartist//app-config (pkg)
  "run config loader for an hackartist app"
  (interactive "P")
  (let* ((app-conf (intern (concat "hackartist/" (concat pkg "/config")))))
    (funcall app-conf)))

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
  (dolist (el hackartist-packages) (add-to-list 'dotspacemacs-additional-packages el))
  (dolist (el hackartist-configuration-layers) (add-to-list 'dotspacemacs-configuration-layers el))
  (dolist (el hackartist-apps) (hackartist//load-app-config el)))

(defun hackartist//load-app-config (app)
  (let ((config (intern (concat "hackartist/" (concat app "/config")))))
    (condition-case nil (funcall config) (error (concat (symbol-name config) " function does not defined")))))


(defun hackartist//layer-init ()
  (setq dotspacemacs-startup-banner nil)
  ;; (setq dotspacemacs-pretty-docs t)
  )
